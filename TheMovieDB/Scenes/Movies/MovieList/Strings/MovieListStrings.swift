import Foundation

struct MovileListStrings {
    private static func localizedString(_ string: String) -> String {
        return NSLocalizedString(string, tableName: "MovieListStrings", bundle: Bundle.main, value: "", comment: "")
    }
    
    static let movieList = localizedString("movieList")    
}
