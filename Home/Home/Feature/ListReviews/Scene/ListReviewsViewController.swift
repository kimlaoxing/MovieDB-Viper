import UIKit
import Declayout
import Components

final class ListReviewsViewController: UIViewController {
    
    var presenter: ListReviewsViewToPresenterProtocol?
    
    private lazy var tableView = UITableView.make {
        $0.edges(to: view)
        $0.delegate = self
        $0.dataSource = self
        $0.register(ListReviewsTableViewCell.self, forCellReuseIdentifier: "ListReviewsTableViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List Reviews"
        presenter?.updateView()
        subViews()
    }
    
    private func subViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
}

extension ListReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListReviewsTableViewCell", for: indexPath) as! ListReviewsTableViewCell
        let row = indexPath.row
        if let data = presenter?.getResult() {
            cell.setContent(with: data[row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getListCount() ?? 0
    }
}

extension ListReviewsViewController: ListReviewsPresenterToViewProtocol {
    
    func showView() {
        self.tableView.reloadData()
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
