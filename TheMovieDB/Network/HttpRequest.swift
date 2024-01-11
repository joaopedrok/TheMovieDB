import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

struct HTTPRequest: Equatable {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]
    var queryItems: [URLQueryItem]

    init(path: String,
         method: HTTPMethod,
         headers: [String: String] = [:],
         queryItems: [URLQueryItem] = []) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryItems = queryItems
    }

    func urlRequest(baseURL: URL) -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        
        print(components?.url)
        
        var request = URLRequest(url: components?.url ?? baseURL)
        request.httpMethod = method.rawValue
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        return request
    }
}
