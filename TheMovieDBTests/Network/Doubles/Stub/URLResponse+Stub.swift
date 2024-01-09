import Foundation

extension URLResponse {
    static func stub(statusCode: Int = 200) -> URLResponse? {
        let url = URL(string: "https://www.example.com")!        
        let headers = ["Content-Type": "application/json"]

        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: headers)
    }
}
