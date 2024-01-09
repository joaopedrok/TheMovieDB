import Foundation

@testable import TheMovieDB

final class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    var dataTask: URLSessionDataTask?
    
    private(set) var dataTaskCount = 0
    private(set) var sentUrlRequest: URLRequest?

    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCount += 1
        sentUrlRequest = urlRequest
        
        completionHandler(data, urlResponse, error)
        
        return dataTask ?? URLSessionDataTask()
    }
    
    private(set) var dataTaskUrlCount = 0
    private(set) var sentUrl: URL?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskUrlCount += 1
        sentUrl = url
        
        completionHandler(data, urlResponse, error)
        
        return dataTask ?? URLSessionDataTask()
    }
}
