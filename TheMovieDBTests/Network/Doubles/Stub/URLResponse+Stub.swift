import Foundation

extension URLResponse {
    static func stub() -> URLResponse? {
        let url = URL(string: "https://www.example.com")!
        let statusCode = 200
        let headers = ["Content-Type": "application/json"]

        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: headers)
    }
}
