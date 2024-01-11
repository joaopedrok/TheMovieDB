import Quick
import Nimble

@testable import TheMovieDB

final class MovieListPresenterTests: QuickSpec {
    override func spec() {
        var sut: MovieListPresenter!
        var repositorySpy: MovieRepositorySpy!
        var viewControllerSpy: MovieListViewControllerSpy!
        
        beforeEach {
            viewControllerSpy = MovieListViewControllerSpy()
            repositorySpy = MovieRepositorySpy()
            sut = MovieListPresenter(repository: repositorySpy,
                                     networkAPIConfiguration: NetworkAPIConfigurationStub())
            sut.viewController = viewControllerSpy
        }
        
        describe("loadMovies") {
            context("when the request succeed") {
                beforeEach {
                    repositorySpy.fetchMoviesResult = .success(MovieListResponse.stub())
                    sut.loadMovies()
                }
                
                it("has to call fetchData") {
                    expect(repositorySpy.fetchMoviesCount).to(equal(1))
                    expect(repositorySpy.sentPage).to(equal(1))
                }
                
                it("has to call show from viewController") {
                    expect(viewControllerSpy.showArgs.count).to(equal(2))
                    expect(viewControllerSpy.showArgs.first).to(equal(.loading))
                    expect(viewControllerSpy.showArgs[1]).to(equal(.ready(MovieListViewPresentation.stubList())))
                }
            }
            
            context("when the request fails") {
                beforeEach {
                    sut.loadMovies()
                }
                
                it("has to call fetchData") {
                    expect(repositorySpy.fetchMoviesCount).to(equal(1))
                    expect(repositorySpy.sentPage).to(equal(1))
                }
                
                it("has to call show from viewController") {
                    expect(viewControllerSpy.showArgs.count).to(equal(2))
                    expect(viewControllerSpy.showArgs.first).to(equal(.loading))
                    expect(viewControllerSpy.showArgs[1]).to(equal(.error(NetworkLayerError.generalError.errorMessage)))
                }
            }
        }
        
        describe("loadNextPage") {
            context("when the request succeed") {
                beforeEach {
                    repositorySpy.fetchMoviesResult = .success(MovieListResponse.stub())
                    sut.loadNextPage()
                }
                
                it("has to call fetchData") {
                    expect(repositorySpy.fetchMoviesCount).to(equal(1))
                    expect(repositorySpy.sentPage).to(equal(2))
                }
                
                it("has to call show from viewController") {
                    expect(viewControllerSpy.showArgs.count).to(equal(1))
                    expect(viewControllerSpy.showArgs.first).to(equal(.ready(MovieListViewPresentation.stubList())))
                }
            }
            
            context("when the request fails") {
                beforeEach {
                    sut.loadNextPage()
                }
                
                it("has to call fetchData") {
                    expect(repositorySpy.fetchMoviesCount).to(equal(1))
                    expect(repositorySpy.sentPage).to(equal(2))
                }
                
                it("has to call show from viewController") {
                    expect(viewControllerSpy.showArgs.count).to(equal(1))
                    expect(viewControllerSpy.showArgs[0]).to(equal(.error(NetworkLayerError.generalError.errorMessage)))
                }
            }
        }
    }
}
