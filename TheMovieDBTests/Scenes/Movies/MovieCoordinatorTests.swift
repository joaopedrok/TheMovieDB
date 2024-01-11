import UIKit
import Quick
import Nimble

@testable import TheMovieDB

final class MovieCoordinatorTest: QuickSpec {
    override func spec() {
        var navigationControllerSpy: UINavigationControllerSpy!
        var sut: MovieCoordinator!
        
        
        beforeEach {
            navigationControllerSpy = UINavigationControllerSpy()
            sut = MovieCoordinator(navigationController: navigationControllerSpy)
        }
        
        describe("start") {
            context("when is called") {
                beforeEach {
                    sut.start()
                }
                
                it("has to call push from navigationController") {
                    expect(navigationControllerSpy.pushViewControllerCount).to(equal(1))
                }
                
                it("has to push MovieListViewController") {
                    let viewController = navigationControllerSpy.pushedViewController as? MovieListViewController
                    expect(viewController).toNot(beNil())
                }
            }
        }
    }
}
