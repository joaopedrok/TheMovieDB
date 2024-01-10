import Foundation

protocol MovieListPresenterType {
    var viewController: MovieListViewControllerType? { get set }
    func loadMovies()
}

final class MovieListPresenter {
    weak var viewController: MovieListViewControllerType?
    
    private let repository: MovieRepositoryType
    
    init(repository: MovieRepositoryType = MovieRepository()) {
        self.repository = repository
    }
}

extension MovieListPresenter: MovieListPresenterType {
    func loadMovies() {
        viewController?.show(state: .loading)
        
        repository.fetchMovies { [weak self] result in
            switch result {
            case let .success(response):
                print(response)
                break
            case let .failure(error):
                self?.viewController?.show(state: .error(error.errorMessage))
            }
        }
    }
}
