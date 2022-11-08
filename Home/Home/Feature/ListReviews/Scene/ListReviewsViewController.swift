import UIKit
import Declayout
import Components

final class ListReviewsViewController: UIViewController {
    
    var presenter: ListReviewsViewToPresenterProtocol?
    var data: [ListReviewsResponse.Result]?
    
    private lazy var tableView = UITableView.make {
        $0.edges(to: view)
        $0.delegate = self
        $0.dataSource = self
        $0.register(ListReviewsTableViewCell.self, forCellReuseIdentifier: "ListReviewsTableViewCell")
    }
    
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
        title = "List Reviews"
        presenter?.updateView()
        subViews()
        bind()
    }
    
    private func subViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(emptyView)
    }
    
    private func bind() {
        self.presenter?.data.observe(on: self) { [weak self] data in
            self?.data = data
            self?.tableView.reloadData()
        }
    }
}

extension ListReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListReviewsTableViewCell", for: indexPath) as! ListReviewsTableViewCell
        let row = indexPath.row
        if let data = self.data {
            cell.setContent(with: data[row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            let indexPath = tableView.indexPath(for: cell)
            presenter?.loadNextPage(index: indexPath?.row ?? 0)
        }
    }
}

extension ListReviewsViewController: ListReviewsPresenterToViewProtocol {
    
    func showEmptyView() {
        self.tableView.isHidden = true
        self.emptyView.isHidden = false
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Internal Server Error", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading(isLoading: Bool) {
        switch isLoading {
        case false:
            self.manageLoadingActivity(isLoading: false)
            self.tableView.isHidden = false
        case true:
            self.manageLoadingActivity(isLoading: true)
            self.tableView.isHidden = true
        }
    }
}
