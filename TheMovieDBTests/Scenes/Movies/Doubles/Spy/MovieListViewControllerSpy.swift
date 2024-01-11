import Foundation
import Quick

@testable import TheMovieDB

final class MovieListViewControllerSpy: MovieListViewControllerType {
    
    private(set) var showArgs = [MovieListViewState]()
    
    func show(state: MovieListViewState) {
        showArgs.append(state)
    }
}
