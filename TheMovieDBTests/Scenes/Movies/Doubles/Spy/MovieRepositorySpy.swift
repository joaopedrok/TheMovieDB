import Foundation

@testable import TheMovieDB

final class MovieRepositorySpy: MovieRepositoryType {
    
    var fetchMoviesResult: Result<MovieListResponse, NetworkLayerError> = .failure(.generalError)
    
    private(set) var fetchMoviesCount = 0
    private(set) var sentPage: Int?
    
    func fetchMovies(page: Int, completion: @escaping (Result<MovieListResponse, NetworkLayerError>) -> Void) {
        fetchMoviesCount += 1
        sentPage = page
        completion(fetchMoviesResult)
    }
}
