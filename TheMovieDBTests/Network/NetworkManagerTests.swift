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

            context("when networkConfiguration and baseUrl are set but queueAsyncExecutor is not set") {
                it("has return a failure result with the appropriate error message") {

                }
            }

            context("when networkConfiguration, baseUrl, and queueAsyncExecutor are set but session is not set") {
                it("has return a failure result with the appropriate error message") {
                }
            }

            context("when networkConfiguration, baseUrl, queueAsyncExecutor, and session are all set") {
                it("has perform the data task and call the completion block with a success result") {
                }

                it("has perform the data task and call the completion block with a failure result if an error occurs") {
                }

                it("has perform the data task and call the completion block with a failure result if data is empty") {

                }

                it("has perform the data task and call the completion block with a failure result if decoding fails") {

                }
            }
        }

        afterEach {
            sut.reset()
        }
    }
}
