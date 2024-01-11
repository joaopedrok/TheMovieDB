import Foundation
import Quick
import Nimble

@testable import TheMovieDB

final class NetworkManagerSpec: QuickSpec {
    override func spec() {
        var sut: NetworkManager!
        var sessionMock: URLSessionMock!
        var networkAPIConfigurationStub: NetworkAPIConfigurationStub!
        var queueAsyncExecutorSpy: QueueAsyncExecutorSpy!
        var urlSessionDataTaskSpy: URLSessionDataTaskSpy!

        beforeEach {
            sessionMock = URLSessionMock()
            networkAPIConfigurationStub = NetworkAPIConfigurationStub()
            queueAsyncExecutorSpy = QueueAsyncExecutorSpy()
            urlSessionDataTaskSpy = URLSessionDataTaskSpy()
            
            sessionMock.dataTask = urlSessionDataTaskSpy
                
            sut = NetworkManager.init(session: sessionMock,
                                      networkConfiguration: networkAPIConfigurationStub,
                                      queueAsyncExecutor: queueAsyncExecutorSpy)
        }
        
        describe("fetchData") {
            context("when networkConfiguration, baseUrl, queueAsyncExecutor, and session are configured") {
                context("when perform the data task call the completion block with a success result") {
                    var resultSent: Result<ObjectMock, NetworkLayerError>?
                    
                    beforeEach {
                        sessionMock.urlResponse = URLResponse.stub()
                        sessionMock.data = "{}".data(using: .utf8)
                        
                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                            resultSent = result
                        }
                    }
                    
                    it("has to make the request with properly urlRequest") {
                        expect(sessionMock.sentUrlRequest?.url?.absoluteString).to(equal("base_url/test?api_key=api_key"))
                    }
                    
                    it("has to return a success result with the approprieted object") {
                        if case let .success(object) = resultSent {
                            expect(object).toNot(beNil())
                        } else {
                            fail()
                        }
                    }
                    
                    it("has to call execute from queueAsyncExecutor") {
                        expect(queueAsyncExecutorSpy.executeCount).to(equal(1))
                    }
                    
                    it("has to call resume from dataTask") {
                        expect(urlSessionDataTaskSpy.resumeCount).to(equal(1))
                    }
                }

                context("when perform the data task and an error occurs") {
                    var resultSent: Result<ObjectMock, NetworkLayerError>?
                    
                    beforeEach {
                        sessionMock.error = NSError(domain: "", code: 0, userInfo: nil)

                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                            resultSent = result
                        }
                    }
                    
                    it("has to make the request with properly urlRequest") {
                        expect(sessionMock.sentUrlRequest?.url?.absoluteString).to(equal("base_url/test?api_key=api_key"))
                    }
                    
                    it("has to return a failure result with the properly error") {
                        if case let .failure(error) = resultSent {
                            expect(error).to(equal(.generalError))
                        } else {
                            fail()
                        }
                    }
                    
                    it("has to call execute from queueAsyncExecutor") {
                        expect(queueAsyncExecutorSpy.executeCount).to(equal(1))
                    }
                    
                    it("has to call resume from dataTask") {
                        expect(urlSessionDataTaskSpy.resumeCount).to(equal(1))
                    }
                }

                context("when perform the data task and data is empty") {
                    var resultSent: Result<ObjectMock, NetworkLayerError>?
                    
                    beforeEach {
                        sessionMock.urlResponse = URLResponse.stub()
                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                            resultSent = result
                        }
                    }
                    
                    it("has to make the request with properly urlRequest") {
                        expect(sessionMock.sentUrlRequest?.url?.absoluteString).to(equal("base_url/test?api_key=api_key"))
                    }
                    
                    it("has to return a failure result with the properly error") {
                        if case let .failure(error) = resultSent {
                            expect(error).to(equal(.dataError))
                        } else {
                            fail()
                        }
                    }
                    
                    it("has to call execute from queueAsyncExecutor") {
                        expect(queueAsyncExecutorSpy.executeCount).to(equal(1))
                    }
                    
                    it("has to call resume from dataTask") {
                        expect(urlSessionDataTaskSpy.resumeCount).to(equal(1))
                    }
                }

                context("when perform the data task and decoding fails") {
                    var resultSent: Result<ObjectMock, NetworkLayerError>?
                    beforeEach {
                        sessionMock.urlResponse = URLResponse.stub()
                        sessionMock.data = "".data(using: .utf8)
                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                            resultSent = result
                        }
                    }
                    
                    it("has to make the request with properly urlRequest") {
                        expect(sessionMock.sentUrlRequest?.url?.absoluteString).to(equal("base_url/test?api_key=api_key"))
                    }
                    
                    it("has to return a failure result with the properly error") {
                        if case let .failure(error) = resultSent {
                            expect(error).to(equal(.parseError))
                        } else {
                            fail()
                        }
                    }
                    
                    it("has to call execute from queueAsyncExecutor") {
                        expect(queueAsyncExecutorSpy.executeCount).to(equal(1))
                    }
                    
                    it("has to call resume from dataTask") {
                        expect(urlSessionDataTaskSpy.resumeCount).to(equal(1))
                    }
                }
                
                context("when perform the data task and there is an invalid status code") {
                    var resultSent: Result<ObjectMock, NetworkLayerError>?

                    beforeEach {
                        sessionMock.urlResponse = URLResponse.stub(statusCode: 400)
                        sessionMock.data = "".data(using: .utf8)
                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                            resultSent = result
                        }
                    }
                    
                    it("has to make the request with properly urlRequest") {
                        expect(sessionMock.sentUrlRequest?.url?.absoluteString).to(equal("base_url/test?api_key=api_key"))
                    }
                    
                    it("has to return a failure result with the properly error") {
                        if case let .failure(error) = resultSent {
                            expect(error).to(equal(.invalidStatusCode(400)))
                        } else {
                            fail()
                        }
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
}
