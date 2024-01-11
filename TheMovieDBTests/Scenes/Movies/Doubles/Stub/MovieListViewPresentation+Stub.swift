import Foundation

@testable import TheMovieDB

extension MovieListViewPresentation {
    static func stubList() -> [MovieListViewPresentation] {
        return [
            MovieListViewPresentation(url: URL(string: "image_url"), title: "Title 1"),
            MovieListViewPresentation(url: URL(string: "image_url"), title: "Title 2")
        ]
    }
}
