import Foundation
import Quick
import Nimble
import UIKit

@testable import TheMovieDB

final class ImageDownloadTests: QuickSpec {
    override func spec() {
        var sut: ImageDownloader!
        var queueAsyncExecutorSpy: QueueAsyncExecutorSpy!
        var urlSessionDataTaskSpy: URLSessionDataTaskSpy!
        var sessionMock: URLSessionMock!
        var imageCacheMock: ImageCacheMock!
        var expectedUrl: URL!

        beforeEach {
            expectedUrl = URL(string: "www.example.com")!
            queueAsyncExecutorSpy = QueueAsyncExecutorSpy()
            urlSessionDataTaskSpy = URLSessionDataTaskSpy()
            sessionMock = URLSessionMock()
            imageCacheMock = ImageCacheMock()
            
            sessionMock.dataTask = urlSessionDataTaskSpy

            sut = ImageDownloader(cache: imageCacheMock,
                                  session: sessionMock,
                                  queue: queueAsyncExecutorSpy)
        }
        
        describe("downloadImage") {
            context("when there is already an image at cache") {
                var expectedImage: UIImage!
                var resultImage: UIImage!

                beforeEach {
                    expectedImage = UIImage(named: "ifood")
                    imageCacheMock.imageToReturn = expectedImage
                                                            
                    sut.downloadImage(from: expectedUrl) { image in
                        resultImage = image
                    }
                }
                
                it("has to return the cached image") {
                    expect(resultImage).to(equal(expectedImage))
                }
                
                it("has to call execute from queueAsyncExecutor") {
                    expect(queueAsyncExecutorSpy.executeCount).to(equal(1))
                }
            }
            
            context("when there is no data") {
                var resultImage: UIImage?
                
                beforeEach {
                    sut.downloadImage(from: expectedUrl) { image in
                        resultImage = image
                    }
                }
                
                it("has to make the request with properly url") {
                    expect(sessionMock.sentUrl).to(equal(expectedUrl))
                }
                
                it("has to return nil") {
                    expect(resultImage).to(beNil())
                }
                
                it("has to call execute from queueAsyncExecutor") {
                    expect(queueAsyncExecutorSpy.executeCount).to(equal(1))
                }
                
                it("has to call resume from dataTask") {
                    expect(urlSessionDataTaskSpy.resumeCount).to(equal(1))
                }
            }
            
            context("when there is an invalid image") {
                var resultImage: UIImage?
                
                beforeEach {
                    sessionMock.data = "".data(using: .utf8)
                    
                    sut.downloadImage(from: expectedUrl) { image in
                        resultImage = image
                    }
                }
                
                it("has to make the request with properly url") {
                    expect(sessionMock.sentUrl).to(equal(expectedUrl))
                }
                
                it("has to make the request with properly url") {
                    expect(sessionMock.sentUrl).to(equal(expectedUrl))
                }
                
                it("has to return nil") {
                    expect(resultImage).to(beNil())
                }
                
                it("has to call execute from queueAsyncExecutor") {
                    expect(queueAsyncExecutorSpy.executeCount).to(equal(1))
                }
                
                it("has to call resume from dataTask") {
                    expect(urlSessionDataTaskSpy.resumeCount).to(equal(1))
                }
            }
            
            context("when there is a valid image") {
                var resultImage: UIImage?
                
                beforeEach {
                    sessionMock.data = UIImage.stubData()
                    
                    sut.downloadImage(from: expectedUrl) { image in
                        resultImage = image
                    }
                }
                
                it("has to make the request with properly url") {
                    expect(sessionMock.sentUrl).to(equal(expectedUrl))
                }
                
                it("has to set image to cache") {
                    expect(imageCacheMock.setObjectCount).to(equal(1))
                    expect(imageCacheMock.sentKey).to(equal(expectedUrl))
                }
                
                it("has to return an image") {
                    expect(resultImage).toNot(beNil())
                }
                
                it("has to call execute from queueAsyncExecutor") {
                    expect(queueAsyncExecutorSpy.executeCount).to(equal(1))
                }
                
                it("has to call resume from dataTask") {
                    expect(urlSessionDataTaskSpy.resumeCount).to(equal(1))
                }
            }
        }
    }
}
