import Foundation

extension Mirror {
    static func accessProperty<T>(from: Any, propertyName: String) -> T? {
        let reflection = Mirror(reflecting: from)
        for child in reflection.children {
            if let name = child.label, name == propertyName {
                return child.value as? T
            }
        }
        return nil
    }
}
