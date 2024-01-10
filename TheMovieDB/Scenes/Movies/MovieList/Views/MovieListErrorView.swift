import UIKit

final class MovieListErrorView: UIView {
    
    var didTapTryAgain: (() -> Void)?
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        return label
    }()
    
    private let tryAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(CommonStrings.tryAgain, for: .normal)
        
        return button
    }()
    
    private let contentView = UIView()
    
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
        addEvents()
    }
    
    private func buildViewHierarchy() {
        addSubview(contentView)
        contentView.addSubview(errorMessageLabel)
        contentView.addSubview(tryAgainButton)
    }
    
    private func addConstraints() {
        contentView.center(in: self)
        
        errorMessageLabel.top(to: contentView)
        errorMessageLabel.left(to: contentView)
        errorMessageLabel.right(to: contentView)
        
        tryAgainButton.under(to: errorMessageLabel, offset: 16)
        tryAgainButton.centerX(to: contentView)
        tryAgainButton.width(150)
        tryAgainButton.bottom(to: contentView)
    }
    
    private func addEvents() {
        tryAgainButton.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
    }
    
    func show(errorMessage: String) {
        errorMessageLabel.text = errorMessage
    }
    
    @objc
    private func tryAgain() {
        didTapTryAgain?()
    }
}
