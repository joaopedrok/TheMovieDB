import UIKit

final class MovieListContentView: UIView {
    
    var didScrollToLoadingMoreMovies: (() -> Void)?
    
    private let collectionView: UICollectionView

    private var movieListDataSource: MovieListDataSource?

    private(set) var isLoadingMoreMovies = false
    
    init(collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())) {
        self.collectionView = collectionView
        super.init(frame: .zero)
        configureCollectionView()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth / 2) - 24
        layout.itemSize = CGSize(width: cellWidth, height: 168)
        
        layout.minimumInteritemSpacing = 14
        layout.minimumLineSpacing = 14
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.register(MovieListViewItemCell.self, forCellWithReuseIdentifier: "MovieListViewItemCell")
    }

    private func configureView() {
        collectionView.delegate = self
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(collectionView)
    }
    
    private func addConstraints() {
        collectionView.top(to: self)
        collectionView.left(to: self)
        collectionView.right(to: self)
        collectionView.bottom(to: self)
    }
    
    func show(movieItemList: [MovieListViewPresentation]) {
        
        let startIndex = movieListDataSource == nil ? 0 : movieItemList.count
        let endIndex = movieItemList.count

        movieListDataSource = MovieListDataSource(movieItemList: movieItemList)
        collectionView.dataSource = movieListDataSource
        
        let indexPaths = (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
        
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: indexPaths)
        }, completion: { _ in
            self.isLoadingMoreMovies = false
        })
    }
}

extension MovieListContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let numberOfMovies = movieListDataSource?.collectionView(collectionView, numberOfItemsInSection: 0) else { return }
        
        if indexPath.row == numberOfMovies - 1 && !isLoadingMoreMovies {
            isLoadingMoreMovies = true
            didScrollToLoadingMoreMovies?()
        }
    }
}
