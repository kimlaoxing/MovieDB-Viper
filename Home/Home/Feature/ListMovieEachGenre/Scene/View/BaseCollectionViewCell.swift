import Declayout
import Components

final class BaseCollectionViewCell: UICollectionViewCell {
    
    private lazy var baseView = BaseView.make {
        $0.edges(to: contentView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        contentView.addSubview(baseView)
        contentView.backgroundColor = .white
    }
    
    func setContent(with data: MovieListResponse.Result) {
        baseView.setContent(with: data)
    }
}
