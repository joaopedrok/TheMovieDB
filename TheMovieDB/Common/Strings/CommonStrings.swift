import Foundation

struct CommonStrings {
    private static func localizedString(_ string: String) -> String {
        return NSLocalizedString(string, tableName: "CommonStrings", bundle: Bundle.main, value: "", comment: "")
    }
    
    static let tryAgain = localizedString("tryAgain")
}
