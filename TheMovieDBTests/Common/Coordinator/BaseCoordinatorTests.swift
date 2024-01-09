import UIKit
import Quick
import Nimble

@testable import TheMovieDB

final class BaseCoordinatorTests: QuickSpec {
    override func spec() {
        var sut: BaseCoordinator!
        
        beforeEach {
            sut = BaseCoordinator(navigationController: UINavigationController())
        }
        
        describe("addChildCoordinator") {
            beforeEach {
                sut.addChildCoordinator(CoordinatorFake())
            }
            
            it("has to add coordinator to childCoordinators") {
                expect(sut.childCoordinators.first).to(beAKindOf(CoordinatorFake.self))
                expect(sut.childCoordinators.count).to(equal(1))
            }
        }
        
        describe("removeChildCoordinator") {
            var coordinator: Coordinator!
            
            beforeEach {
                coordinator = CoordinatorFake()
                sut.addChildCoordinator(coordinator)
                sut.removeChildCoordinator(coordinator)
            }
            
            it("has to remove coordinator from childCoordinators") {
                expect(sut.childCoordinators.count).to(equal(0))
            }
        }
    }
}
