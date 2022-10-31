import Declayout
import Components
import UIKit

final class ListMovieViewController: UIViewController {
    
    var presenter: ListMovieEachGendreViewToPresenterProtocol?
    
    private lazy var scrollView = UIStackView.make {
        $0.edges(to: view)
    }
    
    private var collectionHeight: NSLayoutConstraint? {
        didSet { collectionHeight?.activated() }
    }
    
    private lazy var collection = DefaultCollectionView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        presenter?.updateView()
    }
    
    private func subViews() {
        title = "List Movies"
        view.addSubviews([
            scrollView.addArrangedSubviews([
                collection
            ])
        ])
        collectionConfigure()
    }
    
    private func collectionConfigure() {
        collection.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "BaseCollectionViewCell")
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.isBouncesVertical = true
        collectionHeight = collection.heightAnchor.constraint(equalToConstant: 0)
    }
    
    private func updateCollectionViewHeights() {
        self.collectionHeight?.constant = self.collection.layoutContentSizeHeight
        self.view.layoutIfNeeded()
    }
}

extension ListMovieViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.getMovieListCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseCollectionViewCell",
                                                      for: indexPath) as! BaseCollectionViewCell
        let row = indexPath.row
        let result = presenter?.getResult(index: row)
        if let data = result {
            cell.setContent(with: data)
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
        print("selected")
    }
    
}

extension ListMovieViewController: ListMovieEachGendrePresenterToViewProtocol {
    func showView() {
        self.collection.reloads()
        self.updateCollectionViewHeights()
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
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching News", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
