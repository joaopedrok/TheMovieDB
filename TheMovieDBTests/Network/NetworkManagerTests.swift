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
                
            sut = NetworkManager.shared
        }
        
        describe("fetchData") {
            context("when config was not called ") {
                var resultSent: Result<ObjectMock, NetworkLayerError>?

                beforeEach {
                    sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                        resultSent = result
                    }
                }
                
                it("has to return a failure result with the appropriate error") {
                    if case let .failure(error) = resultSent {
                        expect(error).to(equal(.configError))
                    } else {
                        fail()
                    }
                }
            }
            
            context("when config is called") {
                beforeEach {
                    sut.config(session: sessionMock,
                               networkConfiguration: networkAPIConfigurationStub,
                               queueAsyncExecutor: queueAsyncExecutorSpy)
                }
                
                context("when networkConfiguration is set but baseUrl is nil") {
                    var resultSent: Result<ObjectMock, NetworkLayerError>?

                    beforeEach {
                        networkAPIConfigurationStub.baseUrlTest = nil
                        
                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                            resultSent = result
                        }
                    }
                    
                    it("has to return a failure result with the appropriate error") {
                        if case let .failure(error) = resultSent {
                            expect(error).to(equal(.baseURLError))
                        } else {
                            fail()
                        }
                    }
                }
            }

            context("when networkConfiguration, baseUrl, queueAsyncExecutor, and session are all set") {
                beforeEach {
                    sut.config(session: sessionMock,
                               networkConfiguration: networkAPIConfigurationStub,
                               queueAsyncExecutor: queueAsyncExecutorSpy)
                }
                
                context("when perform the data task call the completion block with a success result") {
                    var resultSent: Result<ObjectMock, NetworkLayerError>?
                    
                    beforeEach {
                        sessionMock.urlResponse = URLResponse.stub()
                        sessionMock.data = "{}".data(using: .utf8)
                        
                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                            resultSent = result
                        }
                    }
                    
                    it("has to return a success result with the approprieted object") {
                        if case let .success(object) = resultSent {
                            expect(object).toNot(beNil())
                        } else {
                            fail()
                        }
                    }
                }

                context("when perform the data task and call completion block with a failure result if an error occurs") {
                    var resultSent: Result<ObjectMock, NetworkLayerError>?
                    
                    beforeEach {
                        sessionMock.error = NSError(domain: "", code: 0, userInfo: nil)

                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                            resultSent = result
                        }
                    }
                    
                    it("has to return a failure result with the appropriate error") {
                        if case let .failure(error) = resultSent {
                            expect(error).to(equal(.generalError))
                        } else {
                            fail()
                        }
                    }
                }

                context("when perform the data task and call the completion block with a failure result if data is empty") {
                    var resultSent: Result<ObjectMock, NetworkLayerError>?
                    
                    beforeEach {
                        sessionMock.urlResponse = URLResponse.stub()
                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                            resultSent = result
                        }
                    }
                    
                    it("has to return a failure result with the appropriate error") {
                        if case let .failure(error) = resultSent {
                            expect(error).to(equal(.dataError))
                        } else {
                            fail()
                        }
                    }
                }

                context("when perform the data task and call the completion block with a failure result if decoding fails") {
                    var resultSent: Result<ObjectMock, NetworkLayerError>?
                    beforeEach {
                        sessionMock.urlResponse = URLResponse.stub()
                        sessionMock.data = "".data(using: .utf8)
                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { result in
                            resultSent = result
                        }
                    }
                    
                    it("has to return a failure result with the appropriate error") {
                        if case let .failure(error) = resultSent {
                            expect(error).to(equal(.parseError))
                        } else {
                            fail()
                        }
                    }
                }
            }
        }

        afterEach {
            sut.reset()
        }
    }
}
