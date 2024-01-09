import UIKit

protocol ImageDownloadable {
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

final class ImageDownloader: ImageDownloadable {
    static let shared = ImageDownloader(cache: ImageCache(),
                                        session: URLSession.shared,
                                        queue: MainThreadExecutor())
    
    private let cache: Cacheable
    private let session: URLSessionProtocol
    private let queue: QueueAsyncExecutor
    
    init(cache: Cacheable,
         session: URLSessionProtocol,
         queue: QueueAsyncExecutor) {
        self.cache = cache
        self.session = session
        self.queue = queue
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: url) {
            queue.execute {
                completion(cachedImage)
            }
            
            return
        }
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                      self?.queue.execute {
                          completion(nil)
                      }
                      
                      return
                  }
            
            self?.cache.setObject(image, forKey: url)
            
            self?.queue.execute {
                completion(image)
            }
        }
        
        task.resume()
    }
}
