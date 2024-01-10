import UIKit

extension UIView {
    func setDynamicHeight(width: CGFloat = 320) {
        let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        let size = self.systemLayoutSizeFitting(targetSize,
                                                withHorizontalFittingPriority: .required,
                                                verticalFittingPriority: .fittingSizeLevel)
        frame.size = size
    }
}
