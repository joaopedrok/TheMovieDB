import Quick
import Nimble
import Nimble_Snapshots
import CoreGraphics

@testable import TheMovieDB

final class MovieListErrorViewTests: QuickSpec {
    override func spec() {
        var sut: MovieListErrorView!
        
        beforeEach {
            sut = MovieListErrorView()
            sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        }
        
        describe("show") {
            beforeEach {
                sut.show(errorMessage: "Error ao realizar request")
            }
            
            it("has to build the layout properly") {
                expect(sut).to(haveValidSnapshot())
            }
        }
        
        describe("addEvents") {
            describe("when button try again is pressed") {
                var didTapTryAgainCount = 0
                
                beforeEach {
                    sut.didTapTryAgain = {
                        didTapTryAgainCount += 1
                    }
                    
                    sut.tryAgainButton?.sendActions(for: .touchUpInside)
                }
                
                it("has to call didTapTryAgain closure") {
                    expect(didTapTryAgainCount).to(equal(1))
                }
            }
        }
    }
}

