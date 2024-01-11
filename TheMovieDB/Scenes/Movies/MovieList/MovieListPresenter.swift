import Foundation

protocol MovieListPresenterType {
    var viewController: MovieListViewControllerType? { get set }
    func loadMovies()
    func loadNextPage()    
}

final class MovieListPresenter {
    weak var viewController: MovieListViewControllerType?
    
    private let repository: MovieRepositoryType
    private let networkAPIConfiguration: NetworkAPIConfiguration
    
    private var moviePresentations = [MovieListViewPresentation]()
    private var currentPage = 1
    
    init(repository: MovieRepositoryType = MovieRepository(),
         networkAPIConfiguration: NetworkAPIConfiguration = NetworkConfiguration.shared) {
        self.repository = repository
        self.networkAPIConfiguration = networkAPIConfiguration
    }
    
    private func createMovieListPresentationList(response: MovieListResponse) {
        for movie in response.results {
            let movieUrl = createImageUrl(posterPath: movie.posterPath)
            let movieItem = MovieListViewPresentation(url: movieUrl, title: movie.title)
            moviePresentations.append(movieItem)
        }
    }
    
    private func createImageUrl(posterPath: String) -> URL? {
        if let imageUrl = networkAPIConfiguration.imageUrl {
            return URL(string: imageUrl + posterPath)
        }
        
        return nil
    }
    
    private func handleFetchMoviesSuccess(response: MovieListResponse) {
        createMovieListPresentationList(response: response)
        viewController?.show(state: .ready(moviePresentations))
    }
    
    private func loadMovies(isPaging: Bool) {
        if !isPaging {
            viewController?.show(state: .loading)
        }
        
        repository.fetchMovies(page: currentPage) { [weak self] result in
            switch result {
            case let .success(response):
                print(response)
                self?.handleFetchMoviesSuccess(response: response)
            case let .failure(error):
                self?.viewController?.show(state: .error(error.errorMessage))
            }
        }
    }
}

extension MovieListPresenter: MovieListPresenterType {
    func loadMovies() {
        loadMovies(isPaging: false)
    }
    
    func loadNextPage() {
        currentPage += 1
        loadMovies(isPaging: true)
    }
}
