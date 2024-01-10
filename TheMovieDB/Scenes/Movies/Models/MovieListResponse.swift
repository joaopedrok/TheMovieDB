import Foundation

struct MovieListResponse: Equatable, Decodable {
    let results: [Movie]
}

struct Movie: Equatable, Decodable {
    let title: String
    let posterPath: String
}
