import UIKit

final class MovieCoordinator: BaseCoordinator {
    override func start() {
        showMovieListViewController()
    }
    
    private func showMovieListViewController() {
        let viewController = MovieListViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
