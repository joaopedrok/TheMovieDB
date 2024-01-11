import Foundation

@testable import TheMovieDB

final class NetworkManagerSpy: DataFetcher {
    
    private(set) var fetchDataCount = 0
    private(set) var sentRequest: HTTPRequest?
    private(set) var sentType: String?
    
    func fetchData<T: Decodable>(with request: HTTPRequest, decodeType: T.Type, completion: @escaping (Result<T, NetworkLayerError>) -> Void) {
        fetchDataCount += 1
        sentRequest = request
        sentType = String(describing: decodeType)
    }
}
