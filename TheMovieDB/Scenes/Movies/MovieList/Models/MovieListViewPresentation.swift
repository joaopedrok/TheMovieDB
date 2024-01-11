import Foundation

enum MovieListViewState: Equatable {
    case ready([MovieListViewPresentation])
    case error(String)
    case loading
}

struct MovieListViewPresentation: Equatable {
    let url: URL?
    let title: String
}
