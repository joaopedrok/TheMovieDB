import Foundation
import UIKit

final class UINavigationControllerSpy: UINavigationController {
    
    private(set) var pushedViewController: UIViewController?
    private(set) var pushedIsAnimated = false
    private(set) var pushViewControllerCount = 0
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCount += 1
        pushedViewController = viewController
        pushedIsAnimated = animated
        super.pushViewController(viewController, animated: false)
    }
}
