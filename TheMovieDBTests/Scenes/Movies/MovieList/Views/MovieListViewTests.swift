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
            sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
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
            
            context("when state is ready") {
                beforeEach {
                    let movieList = [
                        MovieListViewPresentation(url: nil, title: "Teste"),
                        MovieListViewPresentation(url: nil, title: "Teste 1"),
                    ]
                    
                    sut.show(state: .ready(movieList))
                }
                
                it("has to build the layout properly") {
                    expect(sut).to(haveValidSnapshot())
                }
            }
        }
        
        describe("addEvents") {
            describe("tryAgain") {
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
            
            describe("didScrollToLoadingMoreMovies") {
                var didScrollToLoadingMoreMoviesCount = 0
                
                beforeEach {
                    sut.didScrollToLoadingMoreMovies = {
                        didScrollToLoadingMoreMoviesCount += 1
                    }
                    
                    sut.movieListContentView?.didScrollToLoadingMoreMovies?()
                }
                
                it("has to call didScrollToLoadingMoreMovies closure") {
                    expect(didScrollToLoadingMoreMoviesCount).to(equal(1))
                }
            }
        }
    }
}
