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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        presenter?.updateView()
    }
    
    private func subViews() {
        view.backgroundColor = .white
        view.addSubviews([
            vStack.addArrangedSubviews([
                contentView
            ])
        ])
    }
    
    private func updateContent(with data: MovieDetailResponse) {
        contentView.setContent(with: data)
        title = "\(data.title ?? "Detail Movie")"
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
        print("")
    }
}
