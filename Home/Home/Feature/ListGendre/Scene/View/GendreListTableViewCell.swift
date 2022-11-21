import Declayout
import Components
import UIKit

final class GendreListTableViewCell: UITableViewCell {
    
    private lazy var containerView = UIStackView.make {
        $0.axis = .vertical
        $0.horizontalPadding(to: contentView, Padding.double)
        $0.verticalPadding(to: contentView)
        $0.backgroundColor = .white
        $0.spacing = Padding.reguler
    }
    
    private lazy var topSeparator = UIView.make {
        $0.height(0.5)
        $0.backgroundColor = .gray
    }
    
    private lazy var lowSeparator = UIView.make {
        $0.height(0.5)
        $0.backgroundColor = .gray
    }
    
    private lazy var title = UILabel.make {
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
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
                topSeparator,
                title,
                lowSeparator
            ])
        ])
    }
    
    func setContent(with data: GendreResponse.Genre) {
        self.title.text = data.name ?? ""
    }
}
