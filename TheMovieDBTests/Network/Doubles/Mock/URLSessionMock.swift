import Foundation

@testable import TheMovieDB

final class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    var dataTask: URLSessionDataTask?
    
    private(set) var dataTaskCount = 0
    
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
         dataTaskCount += 1
        
        completionHandler(data, urlResponse, error)
        
        return dataTask ?? URLSessionDataTask()
     }
}
