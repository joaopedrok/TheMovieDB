import UIKit

@testable import TheMovieDB

final class CoordinatorFake: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController = UINavigationController()
    
    func start() { }
}
