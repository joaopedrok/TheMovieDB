import Foundation
import UIKit

@testable import TheMovieDB

final class ImageDownloaderSpy: ImageDownloadable {
    
    private(set) var downloadImageCount = 0
    private(set) var sentUrl: URL?
    
    func downloadImage(from url: URL?, completion: @escaping (UIImage?) -> Void) {
        downloadImageCount += 1
        sentUrl = url
    }
}
