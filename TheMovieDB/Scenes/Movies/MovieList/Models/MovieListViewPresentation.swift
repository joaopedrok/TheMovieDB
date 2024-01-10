import Foundation

enum MovieListViewState {
    case ready(MovieListViewPresentation)
    case error(String)
    case loading
}

struct MovieListViewPresentation {
    let url: URL
    let title: String
}
