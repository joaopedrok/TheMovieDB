import UIKit

extension UIImage {
    static func stubData() -> Data? {
        return UIImage(named: "ifood")?.jpegData(compressionQuality: 1.0)
    }
}
