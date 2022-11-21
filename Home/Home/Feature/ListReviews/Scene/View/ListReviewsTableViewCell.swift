import Declayout
import Components
import UIKit

final class ListReviewsTableViewCell: UITableViewCell {
    
    private lazy var containerView = UIStackView.make {
        $0.axis = .vertical
        $0.horizontalPadding(to: contentView, Padding.double)
        $0.verticalPadding(to: contentView, Padding.reguler)
        $0.spacing = 8
    }
    
    private lazy var titleStack = UIStackView.make {
        $0.axis = .horizontal
    }
    
    private lazy var contentStack = UIStackView.make {
        $0.axis = .vertical
    }
    
    private lazy var ratingStack = UIStackView.make {
        $0.axis = .horizontal
    }
    
    private lazy var ratingLabel = UILabel.make {
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .right
    }
    
    private lazy var ratinImage = UIImageView.make {
        $0.clipsToBounds = true
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
        $0.height(10)
    }
    
    private lazy var title = UILabel.make {
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
    }
    
    private lazy var contentTitle = UILabel.make {
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
    }
    
    private lazy var contentValue = UILabel.make {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subViews()
    }
    
    required init?(coder Decoder: NSCoder) {
        super.init(coder: Decoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        contentView.backgroundColor = .white
        contentView.addSubviews([
            containerView.addArrangedSubviews([
                titleStack.addArrangedSubviews([
                    title,
                    ratingStack.addArrangedSubviews([
                        ratinImage,
                        ratingLabel
                    ])
                ]),
                contentStack.addArrangedSubviews([
                    contentTitle,
                    contentValue
                ])
            ])
        ])
    }
    
    func setContent(with data: ListReviewsResponse.Result) {
        self.title.text = data.author ?? ""
        self.ratingLabel.text = "\(data.author_details?.rating ?? 0)"
        self.contentTitle.text = "Content"
        self.ratinImage.image = UIImage(systemName: "star.fill")
        self.contentValue.text = data.content ?? ""
    }
}
