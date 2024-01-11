import Quick
import Nimble
import Nimble_Snapshots
import CoreGraphics

@testable import TheMovieDB
import UIKit

final class MovieListContentViewTests: QuickSpec {
    override func spec() {
        var sut: MovieListContentView!
        var collectionViewMock: UICollectionViewMock!

        beforeEach {
            collectionViewMock = UICollectionViewMock(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            sut = MovieListContentView(collectionView: collectionViewMock)
            sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)            
        }
        
        describe("show") {
            beforeEach {
                sut.show(movieItemList: MovieListViewPresentation.stubList())
            }
            
            it("has to build the layout properly") {
                expect(sut).to(haveValidSnapshot())
            }
        }
        
        describe("UICollectionViewDelegate") {
            beforeEach {
                sut.show(movieItemList: MovieListViewPresentation.stubList())
            }
            
            context("when willDisplayCell is called") {
                var didScrollToLoadingMoreMoviesCount = 0

                beforeEach {
                    sut.didScrollToLoadingMoreMovies = {
                        didScrollToLoadingMoreMoviesCount += 1
                    }
                    sut.collectionView(sut.collectionView!, willDisplay: UICollectionViewCell(frame: .zero), forItemAt: IndexPath(row: 1, section: 0))
                }
                
                it("has to call didScrollToLoadingMoreMovies") {
                    expect(didScrollToLoadingMoreMoviesCount).to(equal(1))
                }
                
                it("has to change isLoadingMoreMovies") {
                    expect(sut.isLoadingMoreMovies).to(beTrue())
                }
            }
        }
    }
}
