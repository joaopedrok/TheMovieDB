import UIKit

protocol MovieListViewControllerType: AnyObject  {
    func show(state: MovieListViewState)
}

final class MovieListViewController: UIViewController {
    
    private let contentView: MovieListViewType
    private let presenter: MovieListPresenterType
    
    init(contentView: MovieListViewType = MovieListView(),
         presenter: MovieListPresenterType) {
        self.contentView = contentView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = MovileListStrings.movieList
        addEvents()
        presenter.loadMovies()
    }
    
    private func addEvents() {
        contentView.didTapTryAgain = { [weak self] in
            self?.presenter.loadMovies()
        }
        
        contentView.didScrollToLoadingMoreMovies = { [weak self] in
            self?.presenter.loadNextPage()
        }
    }
}

extension MovieListViewController: MovieListViewControllerType {
    func show(state: MovieListViewState) {
        contentView.show(state: state)
    }
}
