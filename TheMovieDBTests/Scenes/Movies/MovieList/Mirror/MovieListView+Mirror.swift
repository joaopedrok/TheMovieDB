import Foundation
import UIKit

@testable import TheMovieDB

extension MovieListView {
    var errorView: MovieListErrorView? {
        return Mirror.accessProperty(from: self, propertyName: "errorView")
    }
    
    var movieListContentView: MovieListContentView? {
        return Mirror.accessProperty(from: self, propertyName: "movieListContentView")
    }
}
