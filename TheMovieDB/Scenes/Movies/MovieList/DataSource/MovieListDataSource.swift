import UIKit
import Foundation

final class MovieListDataSource: NSObject, UICollectionViewDataSource {
    private let movieItemList: [MovieListViewPresentation]
    
    init(movieItemList: [MovieListViewPresentation]) {
        self.movieItemList = movieItemList
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListViewItemCell", for: indexPath) as? MovieListViewItemCell else {
            fatalError("Cell was not registered")
        }
        
        let item = movieItemList[indexPath.row]
        cell.show(movieListPresentation: item)
        
        return cell
    }
}
