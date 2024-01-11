import UIKit

@testable import TheMovieDB

final class MovieListViewSpy: UIView, MovieListViewType {
    var didTapTryAgain: (() -> Void)?
    var didScrollToLoadingMoreMovies: (() -> Void)?
    
    private(set) var showCount = 0
    private(set) var sentState: MovieListViewState?
    
    func show(state: MovieListViewState) {
        showCount += 1
        sentState = state
    }
}
