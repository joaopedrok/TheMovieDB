import Foundation
import UIKit

final class MovieListViewItemCell: UICollectionViewCell {
    
    private var imageDownloader: ImageDownloadable? = ImageDownloader.shared
    
    private let movieBannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        backgroundColor = .white
        configureShadow()
        buildCellHierarchy()
        addConstraints()
    }
    
    private func configureShadow() {
        contentView.layer.masksToBounds = true
        
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    private func buildCellHierarchy() {
        contentView.addSubview(movieBannerImageView)
        contentView.addSubview(movieTitleLabel)
    }
    
    private func addConstraints() {
        movieBannerImageView.top(to: contentView, offset: 4)
        movieBannerImageView.left(to: contentView)
        movieBannerImageView.right(to: contentView)
        movieBannerImageView.height(120)
        
        movieTitleLabel.under(to: movieBannerImageView, offset: 4)
        movieTitleLabel.left(to: contentView, offset: 8)
        movieTitleLabel.right(to: contentView, offset: 8)
        movieTitleLabel.bottom(to: contentView, offset: 4)
    }
    
    func updateImageDownloader(imageDownloader: ImageDownloadable) {
        self.imageDownloader = imageDownloader
    }
    
    func show(movieListPresentation: MovieListViewPresentation) {
        imageDownloader?.downloadImage(from: movieListPresentation.url, completion: { [weak self] image in
            self?.movieBannerImageView.image = image
        })
        
        movieTitleLabel.text = movieListPresentation.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieBannerImageView.image = nil
    }
}
