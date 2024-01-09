import UIKit
import Quick
import Nimble

@testable import TheMovieDB

final class AppCoordinatorTests: QuickSpec {
    override func spec() {
        var windowSpy: UIWindowSpy!
        var navigationControllerSpy: UINavigationControllerSpy!
        var sut: AppCoordinator!
        
        beforeEach {
            windowSpy = UIWindowSpy()
            navigationControllerSpy = UINavigationControllerSpy()
            sut = AppCoordinator(window: windowSpy, navigationController: navigationControllerSpy)
        }
        
        describe("start") {
            beforeEach {
                sut.start()
            }
            
            it("has to configure window") {
                expect(windowSpy.rootViewController).to(beIdenticalTo(navigationControllerSpy))
                expect(windowSpy.makeKeyAndVisibleCount).to(equal(1))
            }
            
            it("has to open MovieCoordinator") {
                let viewController = navigationControllerSpy.pushedViewController as? MovieListViewController
                expect(viewController).toNot(beNil())
                expect(navigationControllerSpy.viewControllers.first).to(beIdenticalTo(viewController))
                expect(sut.childCoordinators.first).to(beAKindOf(MovieCoordinator.self))
            }
        }
     }
}
