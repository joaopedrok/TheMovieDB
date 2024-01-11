import Foundation
import Quick
import Nimble

@testable import TheMovieDB

final class MovieRepositoryTests: QuickSpec {
    override func spec() {
        var sut: MovieRepository!
        var networkManagerSpy: NetworkManagerSpy!
        
        beforeEach {
            networkManagerSpy = NetworkManagerSpy()
            sut = MovieRepository(dataFetcher: networkManagerSpy)
        }
        
        describe("fetchMovies") {
            beforeEach {
                sut.fetchMovies(page: 1) { _ in }
            }
            
            it("has to call fetchData from networkManager") {
                expect(networkManagerSpy.fetchDataCount).to(equal(1))
                var expectedHttpRequest = HTTPRequest(path: "movie/popular", method: .get)
                expectedHttpRequest.queryItems.append(URLQueryItem(name: "page", value: String(1)))
                expect(networkManagerSpy.sentRequest).to(equal(expectedHttpRequest))
                expect(networkManagerSpy.sentType).to(equal(String(describing: MovieListResponse.self)))
            }
        }
    }
}
