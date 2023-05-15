import Declayout
import Components
import UIKit

final class ListMovieViewController: UIViewController {
    
    var presenter: ListMovieEachGenreViewToPresenterProtocol?
    var data: [MovieListResponse.Result]?
    
    private lazy var scrollView = UIStackView.make {
        $0.edges(to: view)
        $0.backgroundColor = .white
    }
    
    private var collectionHeight: NSLayoutConstraint? {
        didSet { collectionHeight?.activated() }
    }
    
    private lazy var collection = DefaultCollectionView(frame: .zero)
    
    private lazy var emptyView = EmptyDataView.make {
        $0.isHidden = true
        $0.button.isHidden = true
        $0.center(to: view)
        $0.title.text = "Reviews is Empty"
        $0.title.font = .systemFont(ofSize: 12, weight: .bold)
        $0.title.numberOfLines = 0
        $0.image.width(100)
        $0.image.tintColor = .black
        $0.image.image = UIImage(systemName: "nosign")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        presenter?.updateView()
        bind()
    }
    
    private func subViews() {
        title = presenter?.getGenresName()
        view.backgroundColor = .white
        view.addSubviews([
            scrollView.addArrangedSubviews([
                collection
            ])
        ])
        view.addSubview(emptyView)
        collectionConfigure()
    }
    
    private func bind() {
        self.presenter?.response.observe(on: self) { [weak self] data in
            guard let self = self else { return }
            self.data = data
            self.collection.reloads()
            self.updateCollectionViewHeights()
        }
    }
    
    private func collectionConfigure() {
        collection.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "BaseCollectionViewCell")
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .white
        collection.isBouncesVertical = true
        collectionHeight = collection.heightAnchor.constraint(equalToConstant: 0)
    }
    
    private func updateCollectionViewHeights() {
        self.collectionHeight?.constant = self.collection.layoutContentSizeHeight
        self.view.layoutIfNeeded()
    }
}

extension ListMovieViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collection.visibleCells {
            let indexPath = collection.indexPath(for: cell)
            presenter?.loadNextPage(index: indexPath?.row ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseCollectionViewCell",
                                                      for: indexPath) as! BaseCollectionViewCell
        let row = indexPath.row
        if let data = data {
            cell.setContent(with: data[row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UICollectionViewTwoItemPerWidth()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Padding.reguler, left: Padding.double, bottom: Padding.reguler, right: Padding.double)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        if let id = self.data?[row].id {
            self.presenter?.toMovieDetail(with: id)
        }
    }
    
}

extension ListMovieViewController: ListMovieEachGenrePresenterToViewProtocol {
    func showEmptyView() {
        self.emptyView.isHidden = false
        self.scrollView.isHidden = true
    }
    
    func showLoading(isLoading: Bool) {
        switch isLoading {
        case false:
            self.manageLoadingActivity(isLoading: false)
            self.collection.isHidden = false
        case true:
            self.manageLoadingActivity(isLoading: true)
            self.collection.isHidden = true
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
}
