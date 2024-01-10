import UIKit

final class MovieCoordinator: BaseCoordinator {
    override func start() {
        showMovieListViewController()
    }
    
    private func showMovieListViewController() {
        let presenter = MovieListPresenter()
        let viewController = MovieListViewController(presenter: presenter)
        presenter.viewController = viewController
        navigationController.pushViewController(viewController, animated: true)
    }
}
