import UIKit

final class MovieListContentView: UIView {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MovieListViewItemCell.self, forCellWithReuseIdentifier: "MovieListViewItemCell")
        
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = .white
        buildViewHierarchy()
        addConstraints()
        
    }
    
    private func buildViewHierarchy() {
        
    }
    
    private func addConstraints() {
        
    }
}
