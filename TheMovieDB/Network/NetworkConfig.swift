import Foundation

protocol NetworkAPIConfiguration {
    var apiKey: String? { get }
    var baseUrl: String? { get }
    var imageUrl: String? { get }
}

final class NetworkConfiguration: NetworkAPIConfiguration {
    static let shared = NetworkConfiguration()

    let apiKey: String?
    let baseUrl: String?
    let imageUrl: String?

    private init() {
        apiKey = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String
        baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String
        imageUrl = Bundle.main.object(forInfoDictionaryKey: "ImageURL") as? String
    }
}
