import UIKit
import Declayout
import Components

final class MovieDetailViewController: UIViewController {
    
    var presenter: MovieDetailViewToPresenterProtocol?
    
    private lazy var contentView = MovieDetailView()
    
    private lazy var vStack = UIStackView.make {
        $0.axis = .vertical
        $0.top(to: view, Padding.double + safeAreaInset.top + Padding.half)
        $0.bottom(to: view, Padding.double)
        $0.horizontalPadding(to: view)
    }
    
    private lazy var container = UIView.make {
        $0.height(Padding.NORMAL_CONTENT_INSET)
    }
    
    private lazy var reviewButton = UIButton.make {
        $0.verticalPadding(to: container)
        $0.horizontalPadding(to: container, Padding.reguler)
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.setTitle("Review", for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(toListReview), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        presenter?.updateView()
    }
    
    private func subViews() {
        view.backgroundColor = .white
        view.addSubviews([
            vStack.addArrangedSubviews([
                contentView,
                container.addSubviews([
                    reviewButton
                ])
            ])
        ])
    }
    
    private func updateContent(with data: MovieDetailResponse) {
        contentView.setContent(with: data)
        title = "\(data.title ?? "Detail Movie")"
    }
    
    @objc private func toListReview() {
        
    }
}

extension MovieDetailViewController: MovieDetailPresenterToViewProtocol {
    func showView() {
        if let data = presenter?.getResult() {
            self.updateContent(with: data)
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching News", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading(isLoading: Bool) {
        switch isLoading {
        case false:
            self.manageLoadingActivity(isLoading: false)
            self.vStack.isHidden = false
        case true:
            self.manageLoadingActivity(isLoading: true)
            self.vStack.isHidden = true
        }
    }
}
