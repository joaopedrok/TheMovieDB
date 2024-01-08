import Foundation

@testable import TheMovieDB

extension HTTPRequest {
    static func stub() -> HTTPRequest {
        return  HTTPRequest(path: "/test", method: .get)
    }
}
