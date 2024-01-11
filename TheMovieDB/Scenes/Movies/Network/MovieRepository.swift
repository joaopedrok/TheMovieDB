import Foundation

protocol MovieRepositoryType {
    func fetchMovies(page: Int, completion: @escaping (Result<MovieListResponse, NetworkLayerError>) -> Void)
}

final class MovieRepository {
    private let dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkManager.shared) {
        self.dataFetcher = dataFetcher
    }
}

extension MovieRepository: MovieRepositoryType {
    func fetchMovies(page: Int, completion: @escaping (Result<MovieListResponse, NetworkLayerError>) -> Void) {
        var request = HTTPRequest(path: "movie/popular", method: .get)
        request.queryItems.append(URLQueryItem(name: "page", value: String(page)))
        dataFetcher.fetchData(with: request, decodeType: MovieListResponse.self, completion: completion)
    }
}
