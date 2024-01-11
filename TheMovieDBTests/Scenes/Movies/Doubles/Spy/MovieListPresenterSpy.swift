import Foundation

@testable import TheMovieDB

final class MovieListPresenterSpy: MovieListPresenterType {
    weak var viewController: MovieListViewControllerType?
    
    private(set) var loadMoviesCount = 0
    
    func loadMovies() {
        loadMoviesCount += 1
    }
    
    private(set) var loadNextPageCount = 0
    
    func loadNextPage() {
        loadNextPageCount += 1
    }
}
