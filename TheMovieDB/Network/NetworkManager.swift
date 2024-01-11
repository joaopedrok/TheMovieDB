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
    static let shared = NetworkManager(session: URLSession.shared,
                                       networkConfiguration: NetworkConfiguration.shared,
                                       queueAsyncExecutor: MainThreadExecutor())
    
    private let session: URLSessionProtocol
    private let networkConfiguration: NetworkAPIConfiguration
    private let queueAsyncExecutor: QueueAsyncExecutor

    init(session: URLSessionProtocol, networkConfiguration:
         NetworkAPIConfiguration, queueAsyncExecutor: QueueAsyncExecutor) {
        self.session = session
        self.networkConfiguration = networkConfiguration
        self.queueAsyncExecutor = queueAsyncExecutor
    }
}

extension NetworkManager: DataFetcher {
    func fetchData<T: Decodable>(with request: HTTPRequest, decodeType: T.Type, completion: @escaping (Result<T, NetworkLayerError>) -> Void) {
        
        var request = request

        guard let url = URL(string: networkConfiguration.baseUrl ?? ""),
              let apiKey = networkConfiguration.apiKey else {
            fatalError(NetworkLayerError.baseURLError.errorMessage)
        }
        
        request.queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
            
        let urlRequest = request.urlRequest(baseURL: url)

        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            if error != nil {
                self?.queueAsyncExecutor.execute {
                    completion(.failure(.generalError))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...300).contains(httpResponse.statusCode) {
                self?.queueAsyncExecutor.execute {
                    completion(.failure(.invalidStatusCode(httpResponse.statusCode)))
                }
                return
            }

            guard let data = data else {
                self?.queueAsyncExecutor.execute {
                    completion(.failure(.dataError))
                }

                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedObject = try decoder.decode(T.self, from: data)
                self?.queueAsyncExecutor.execute {
                    completion(.success(decodedObject))
                }
            } catch {
                self?.queueAsyncExecutor.execute {
                    completion(.failure(.parseError))
                }
            }
        }

        task.resume()
    }
}
