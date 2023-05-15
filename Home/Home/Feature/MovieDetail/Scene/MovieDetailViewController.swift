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
    
    private lazy var buttonStack = UIStackView.make {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    private lazy var listTrailerButtonContainer = UIView.make {
        $0.height(Padding.NORMAL_CONTENT_INSET)
        $0.width(ScreenSize.width * 0.5)
    }
    
    private lazy var reviewButtonContainer = UIView.make {
        $0.height(Padding.NORMAL_CONTENT_INSET)
        $0.width(ScreenSize.width * 0.5)
    }
    
    private lazy var reviewButton = UIButton.make {
        $0.verticalPadding(to: reviewButtonContainer)
        $0.horizontalPadding(to: reviewButtonContainer, Padding.reguler)
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.setTitle("Review", for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(toListReview), for: .touchUpInside)
    }
    
    private lazy var listTrailerButton = UIButton.make {
        $0.verticalPadding(to: listTrailerButtonContainer)
        $0.horizontalPadding(to: listTrailerButtonContainer, Padding.reguler)
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.setTitle("List Trailer", for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(toListTrailer), for: .touchUpInside)
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
                buttonStack.addArrangedSubviews([
                    reviewButtonContainer.addSubviews([
                        reviewButton
                    ]),
                    listTrailerButtonContainer.addSubviews([
                        listTrailerButton
                    ])
                ])
            ])
        ])
    }
    
    private func updateContent(with data: MovieDetailResponse) {
        contentView.setContent(with: data)
        title = "\(data.title ?? "Detail Movie")"
    }
    
    @objc private func toListReview() {
        if let data = presenter?.getResult()?.id {
            self.presenter?.toMovieReviews(with: data)
        }
    }
    
    @objc private func toListTrailer() {
        if let data = presenter?.getResult()?.id {
            self.presenter?.toListTrailer(with: data)
        }
    }
}

extension MovieDetailViewController: MovieDetailPresenterToViewProtocol {
    func showView() {
        if let data = presenter?.getResult() {
            self.updateContent(with: data)
        }
    }
    
    func showError() {
        let error = self.presenter?.getError()
        let alert = UIAlertController(
            title: "Alert",
            message: "\(String(describing: error))",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(
            title: "Okay",
            style: UIAlertAction.Style.default,
            handler: nil)
        )
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
