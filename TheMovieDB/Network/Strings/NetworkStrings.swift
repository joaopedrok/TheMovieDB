import Foundation

struct NetworkStrings {
    private static func localizedString(_ string: String) -> String {
        return NSLocalizedString(string, tableName: "NetworkStrings", bundle: Bundle.main, value: "", comment: "")
    }
    
    static let configError = localizedString("configError")
    static let dataError = localizedString("dataError")
    static let baseURLError = localizedString("baseURLError")
    static let generalError = localizedString("generalError")
    static let parseError = localizedString("parseError")
    static let invalidStatusCode = localizedString("invalidStatusCode")
}
