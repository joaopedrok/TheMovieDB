import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        startMoviesFlow()
    }
    
    private func startMoviesFlow() {
        let coordinator = MovieCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}
