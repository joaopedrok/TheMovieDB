import Foundation

@testable import TheMovieDB

final class NetworkAPIConfigurationStub: NetworkAPIConfiguration {
    
    var apiKeyTest: String? = "api_key"
    var baseUrlTest: String? = "base_url"
    var imageUrlTest: String? = "image_url"
    
    var apiKey: String? {
        return apiKeyTest
    }
    
    var baseUrl: String? {
        return baseUrlTest
    }
    
    var imageUrl: String? {
        return imageUrlTest
    }
}
