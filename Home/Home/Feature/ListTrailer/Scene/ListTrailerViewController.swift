import Declayout
import Components

final class ListTrailerViewController: UIViewController {
    
    var presenter: ListTrailerViewToPresenterProtocol?
    
    private lazy var container = ScrollViewContainer.make {
        $0.edges(to: view)
        $0.backgroundColor = .white
    }
    
    private lazy var collection = DefaultCollectionView(frame: .zero)
    
    private var collectionHeight: NSLayoutConstraint? {
        didSet { collectionHeight?.activated() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView()
        subViews()
    }
    
    private func subViews() {
        view.backgroundColor = .white
        title = "List Trailer"
        view.addSubviews([
            container.addArrangedSubViews([
                collection
            ])
        ])
        configureCollection()
    }
    
    private func configureCollection() {
        collection.isBouncesVertical = true
        collection.dataSource = self
        collection.delegate = self
        collection.register(ListTrailerUICollectionViewCell.self, forCellWithReuseIdentifier: "ListTrailerUICollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .white
        collectionHeight = collection.heightAnchor.constraint(equalToConstant: 0)
    }
    
    private func updateCollectionViewHeights() {
        self.collectionHeight?.constant = self.collection.layoutContentSizeHeight
        self.view.layoutIfNeeded()
    }
}

extension ListTrailerViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListTrailerUICollectionViewCell",
                                                      for: indexPath) as! ListTrailerUICollectionViewCell
        let result = presenter?.getResult()
        if let data = result {
            cell.setContent(with: data[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getNumberOfCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UICollectionViewOneItemPerWidth()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Padding.reguler, left: 0, bottom: Padding.reguler, right: 0)
    }
}

extension ListTrailerViewController: ListTrailerPresenterToViewProtocol {
    func showView() {
        self.collection.reloadData()
        self.updateCollectionViewHeights()
    }
    
    func showLoading(isLoading: Bool) {
        switch isLoading {
        case false:
            self.manageLoadingActivity(isLoading: false)
            self.container.isHidden = false
        case true:
            self.manageLoadingActivity(isLoading: true)
            self.container.isHidden = true
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Internal Server Error", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
