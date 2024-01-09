import UIKit

final class UIWindowSpy: UIWindow {
    private(set) var makeKeyAndVisibleCount = 0
    
    override func makeKeyAndVisible() {
        makeKeyAndVisibleCount += 1
        super.makeKeyAndVisible()
    }
}
