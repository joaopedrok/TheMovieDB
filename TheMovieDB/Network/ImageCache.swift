import UIKit

protocol Cacheable {
    func object(forKey key: URL) -> UIImage?
    func setObject(_ obj: UIImage, forKey key: URL)
}

final class ImageCache: Cacheable {
    
    private var cache = NSCache<NSURL, UIImage>()
    
    func object(forKey key: URL) -> UIImage? {
        let url = key as NSURL
        return cache.object(forKey: url)
    }
    
    func setObject(_ obj: UIImage, forKey key: URL) {
        let url = key as NSURL
        cache.setObject(obj, forKey: url)
    }
}
