import Quick
import Nimble
import Nimble_Snapshots
import CoreGraphics

@testable import TheMovieDB

final class MovieListViewTests: QuickSpec {
    override func spec() {
        var sut: MovieListView!

        beforeEach {
            sut = MovieListView()
            sut.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
        }

        describe("show") {
            context("when state is error") {
                beforeEach {
                    sut.show(state: .error("Error message"))
                }

                it("has to build the layout properly") {
                    expect(sut).to(haveValidSnapshot())
                }
            }
            
            context("when state is loading") {
                beforeEach {
                    sut.show(state: .loading)
                }

                it("has to build the layout properly") {
                    expect(sut).to(haveValidSnapshot())
                }
            }
        }
        
        describe("addEvents") {
            context("when tryAgain button is pressed") {
                var didTapTryAgainCount = 0
                
                beforeEach {
                    sut.didTapTryAgain = {
                        didTapTryAgainCount += 1
                    }
                    
                    sut.errorView?.didTapTryAgain?()
                }
                
                it("has to call didTapTryAgain closure") {
                    expect(didTapTryAgainCount).to(equal(1))
                }
            }
        }
    }
}
