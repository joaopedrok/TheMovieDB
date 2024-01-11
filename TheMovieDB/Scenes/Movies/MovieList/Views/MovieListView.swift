import UIKit

protocol MovieListViewType where Self: UIView {
    var didTapTryAgain: (() -> Void)? { get set }
    var didScrollToLoadingMoreMovies: (() -> Void)? { get set }
    func show(state: MovieListViewState)
}

final class MovieListView: UIView {
    var didTapTryAgain: (() -> Void)?
    var didScrollToLoadingMoreMovies: (() -> Void)?
    
    private let errorView: MovieListErrorView = {
        let view = MovieListErrorView()
        view.isHidden = true

        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true

        return activityIndicator
    }()

    private let movieListView = MovieListContentView()
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .white
        buildViewHierarchy()
        addConstraints()
        addEvents()
    }
    
    private func buildViewHierarchy() {
        addSubview(errorView)
        addSubview(activityIndicator)
        addSubview(movieListView)
    }
    
    private func addConstraints() {
        errorView.topToSafeArea(of: self)
        errorView.left(to: self)
        errorView.right(to: self)
        errorView.bottomToSafeArea(of: self)
        
        activityIndicator.center(in: self)
        
        movieListView.topToSafeArea(of: self)
        movieListView.left(to: self)
        movieListView.right(to: self)
        movieListView.bottomToSafeArea(of: self)
    }
    
    private func addEvents() {
        errorView.didTapTryAgain = { [weak self] in
            self?.didTapTryAgain?()
        }
        
        movieListView.didScrollToLoadingMoreMovies = { [weak self] in
            self?.didScrollToLoadingMoreMovies?()            
        }
    }
    
    private func showLoadingState() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        errorView.isHidden = true
        movieListView.isHidden = true
    }
    
    private func showErrorState(message: String) {
        activityIndicator.stopAnimating()
        errorView.isHidden = false
        activityIndicator.isHidden = true
        movieListView.isHidden = true
        errorView.show(errorMessage: message)
    }
    
    private func showReadyState(movieItemList: [MovieListViewPresentation]) {
        movieListView.show(movieItemList: movieItemList)
        activityIndicator.stopAnimating()
        errorView.isHidden = true
        activityIndicator.isHidden = true
        movieListView.isHidden = false
    }
}

extension MovieListView: MovieListViewType {
    func show(state: MovieListViewState) {
        switch state {
        case let .ready(movieItemList):
            showReadyState(movieItemList: movieItemList)
        case let .error(message):
            showErrorState(message: message)
        case .loading:
            showLoadingState()
        }
    }
}
