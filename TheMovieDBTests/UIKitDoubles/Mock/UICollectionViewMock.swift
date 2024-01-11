import UIKit

final class UICollectionViewMock: UICollectionView {
    
    private(set) var performBatchUpdatesCount = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        performBatchUpdatesCount += 1
        updates?()
        completion?(true)
    }
}
