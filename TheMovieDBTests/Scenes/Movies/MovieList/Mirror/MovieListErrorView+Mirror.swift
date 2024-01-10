import Foundation
import UIKit

@testable import TheMovieDB

extension MovieListErrorView {
    var tryAgainButton: UIButton? {        
        return Mirror.accessProperty(from: self, propertyName: "tryAgainButton")
    }
}
