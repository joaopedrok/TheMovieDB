import UIKit

@testable import TheMovieDB

final class ImageCacheMock: Cacheable {
     
    var imageToReturn: UIImage?
    
    private(set) var objectCount = 0
    private(set) var sentKey: URL?

    func object(forKey key: URL) -> UIImage? {
        objectCount += 1
        sentKey = key
        return imageToReturn
    }
    
    private(set) var setObjectCount = 0
    private(set) var sentObj: UIImage?
    private(set) var sentSetObjectKey: URL?

    func setObject(_ obj: UIImage, forKey key: URL) {
        setObjectCount += 1
        sentObj = obj
        sentSetObjectKey = key
    }
}
