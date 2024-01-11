import Foundation

@testable import TheMovieDB

extension MovieListResponse {
    static func stub() -> MovieListResponse {
        let movies = [
            Movie(title: "Title 1", posterPath: ""),
            Movie(title: "Title 2", posterPath: ""),
        ]

        return MovieListResponse(results: movies)
    }
}
