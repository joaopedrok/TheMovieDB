import Quick
import Nimble
import Nimble_Snapshots
import CoreGraphics
import Foundation

@testable import TheMovieDB

final class MovieListViewItemCellTests: QuickSpec {
    override func spec() {
        var sut: MovieListViewItemCell!
        var imageDownloaderSpy: ImageDownloaderSpy!
        
        beforeEach {
            imageDownloaderSpy = ImageDownloaderSpy()
            sut = MovieListViewItemCell(frame: CGRect(x: 0, y: 0, width: 100, height: 168))
            sut.updateImageDownloader(imageDownloader: imageDownloaderSpy)
        }
        
        describe("show") {
            beforeEach {
                sut.show(movieListPresentation: MovieListViewPresentation.stubList()[0])
            }
            
            it("has to build the layout properly") {
                expect(sut).to(haveValidSnapshot()())
            }
            
            it("has to call downloadImage from imageDownload") {
                expect(imageDownloaderSpy.downloadImageCount).to(equal(1))
                expect(imageDownloaderSpy.sentUrl).to(equal(URL(string: "image_url")))
            }
        }
    }
}
