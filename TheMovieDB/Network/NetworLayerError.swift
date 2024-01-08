import Foundation

enum NetworkLayerError: Equatable, Error {
    case configError
    case baseURLError
    case dataError
    case generalError
    case parseError
    
    var errorMessage: String {
        switch self {
        case .configError:
            return NetworkStrings.configError
        case .baseURLError:
            return NetworkStrings.baseURLError
        case .dataError:
            return NetworkStrings.dataError
        case .generalError:
            return NetworkStrings.generalError
        case .parseError:
            return NetworkStrings.parseError
        }
    }
}
