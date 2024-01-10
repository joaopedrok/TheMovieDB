import Foundation

protocol MovieRepositoryType {
    func fetchMovies(completion: @escaping (Result<MovieListResponse, NetworkLayerError>) -> Void)
}


final class MovieRepository {
    private let dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkManager.shared) {
        self.dataFetcher = dataFetcher
    }
}

extension MovieRepository: MovieRepositoryType {
    func fetchMovies(completion: @escaping (Result<MovieListResponse, NetworkLayerError>) -> Void) {
        let request = HTTPRequest(path: "movie/popular", method: .get)
        dataFetcher.fetchData(with: request, decodeType: MovieListResponse.self, completion: completion)
    }
}
