import Foundation
import UIKit

@testable import TheMovieDB

extension MovieListContentView {
    var collectionView: UICollectionView? {
        return Mirror.accessProperty(from: self, propertyName: "collectionView")
    }
}
