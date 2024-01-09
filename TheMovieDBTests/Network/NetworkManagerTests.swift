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
            context("when config was not called") {
                it("has to throw an fatalError") {
                    expect {
                        sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { _ in }
                    }.to(throwAssertion())
                }
            }
            
            context("when config is called") {
                beforeEach {
                    sut.config(session: sessionMock,
                               networkConfiguration: networkAPIConfigurationStub,
                               queueAsyncExecutor: queueAsyncExecutorSpy)
                }
                
                context("when networkConfiguration is set but baseUrl is nil") {
                    beforeEach {
                        networkAPIConfigurationStub.baseUrlTest = nil
                    }
                    
                    it("has to throw an fatalError") {
                        expect {
                            sut.fetchData(with: HTTPRequest.stub(), decodeType: ObjectMock.self) { _ in }
                        }.to(throwAssertion())
                    }
                }
            }

            context("when networkConfiguration, baseUrl, queueAsyncExecutor, and session are configured") {
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
                    
                    it("has to make the request with properly urlRequest") {
                        expect(sessionMock.sentUrlRequest).to(equal(HTTPRequest.stub().urlRequest(baseURL: URL(string: "base_url")!)))
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
                        expect(sessionMock.sentUrlRequest).to(equal(HTTPRequest.stub().urlRequest(baseURL: URL(string: "base_url")!)))
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
                        expect(sessionMock.sentUrlRequest).to(equal(HTTPRequest.stub().urlRequest(baseURL: URL(string: "base_url")!)))
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
                        expect(sessionMock.sentUrlRequest).to(equal(HTTPRequest.stub().urlRequest(baseURL: URL(string: "base_url")!)))
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
                        expect(sessionMock.sentUrlRequest).to(equal(HTTPRequest.stub().urlRequest(baseURL: URL(string: "base_url")!)))
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

        afterEach {
            sut.reset()
        }
    }
}
