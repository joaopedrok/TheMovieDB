import Foundation
import UIKit

final class MovieListViewItemCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        buildCellHierarchy()
        addConstraints()
    }
    
    private func buildCellHierarchy() {
        
    }
    
    private func addConstraints() {
        
    }
}
