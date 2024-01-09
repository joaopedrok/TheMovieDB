import Foundation

protocol URLSessionProtocol {
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

protocol DataFetcher {
    func fetchData<T: Decodable>(with request: HTTPRequest, decodeType: T.Type, completion: @escaping (Result<T, NetworkLayerError>) -> Void)
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private var session: URLSessionProtocol?
    private var networkConfiguration: NetworkAPIConfiguration?
    private var queueAsyncExecutor: QueueAsyncExecutor?

    private init() { }
    
    func config(session: URLSessionProtocol = URLSession.shared,
                networkConfiguration:
                NetworkAPIConfiguration = NetworkConfiguration.shared,
                queueAsyncExecutor: QueueAsyncExecutor = MainThreadExecutor()) {
        self.session = session
        self.networkConfiguration = networkConfiguration
        self.queueAsyncExecutor = queueAsyncExecutor
    }
    
    func reset() {
        session = nil
        networkConfiguration = nil
        queueAsyncExecutor = nil
    }
}

extension NetworkManager: DataFetcher {
    func fetchData<T: Decodable>(with request: HTTPRequest, decodeType: T.Type, completion: @escaping (Result<T, NetworkLayerError>) -> Void) {
        
        guard let networkConfiguration = networkConfiguration,
              let queueAsyncExecutor = queueAsyncExecutor,
              let session = session else {
                  fatalError(NetworkLayerError.configError.errorMessage)            
        }
        
        guard let url = URL(string: networkConfiguration.baseUrl ?? "") else {
            fatalError(NetworkLayerError.baseURLError.errorMessage)
        }
            
        let urlRequest = request.urlRequest(baseURL: url)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                queueAsyncExecutor.execute {
                    completion(.failure(.generalError))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...300).contains(httpResponse.statusCode) {
                queueAsyncExecutor.execute {
                    completion(.failure(.invalidStatusCode(httpResponse.statusCode)))
                }
                return
            }

            guard let data = data else {
                queueAsyncExecutor.execute {
                    completion(.failure(.dataError))
                }

                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                queueAsyncExecutor.execute {
                    completion(.success(decodedObject))
                }
            } catch {
                queueAsyncExecutor.execute {
                    completion(.failure(.parseError))
                }
            }
        }

        task.resume()
    }
}
