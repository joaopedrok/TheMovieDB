import Nimble
import Quick

@testable import TheMovieDB

final class MovieListViewControllerTests: QuickSpec {
    override func spec() {
        var sut: MovieListViewController!
        var presenterSpy: MovieListPresenterSpy!
        var viewSpy: MovieListViewSpy!

        beforeEach {
            presenterSpy = MovieListPresenterSpy()
            viewSpy = MovieListViewSpy()
            sut = MovieListViewController(contentView: viewSpy, presenter: presenterSpy)
            _ = sut.view
        }
        
        describe("loadView") {
            it("has set an MovieListView as view") {
                expect(sut.view).to(beAKindOf(MovieListViewSpy.self))
            }
        }
        
        describe("viewDidLoad") {
            it("has to change viewController title") {
                expect(sut.title).to(equal("Lista de filmes"))
            }
            
            it("has to call loadMovies from presenter") {
                expect(presenterSpy.loadMoviesCount).to(equal(1))
            }
        }
        
        describe("addEvents") {
            describe("didTapTryAgain") {
                beforeEach {
                    viewSpy.didTapTryAgain?()
                }
                
                it("has to call loadMovies from presenter") {
                    expect(presenterSpy.loadMoviesCount).to(equal(2))
                }
            }
            
            describe("didScrollToLoadingMoreMovies") {
                beforeEach {
                    viewSpy.didScrollToLoadingMoreMovies?()
                }
                
                it("has to call loadNextPage from presenter") {
                    expect(presenterSpy.loadNextPageCount).to(equal(1))
                }
            }
        }
        
        describe("show") {
            beforeEach {
                sut.show(state: .loading)
            }
            
            it("has to call show from view") {
                expect(viewSpy.showCount).to(equal(1))
                expect(viewSpy.sentState).to(equal(.loading))
            }
        }
    }
}

