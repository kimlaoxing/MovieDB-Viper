import Declayout
import UIKit
import Components

final class GendreListViewController: UIViewController {
    
    var presenter: BaseListViewToPresenterProtocol?
    
    private lazy var tableView = UITableView.make {
        $0.edges(to: view)
        $0.delegate = self
        $0.dataSource = self
        $0.register(GendreListTableViewCell.self, forCellReuseIdentifier: "GendreListTableViewCell")
        $0.allowsMultipleSelectionDuringEditing = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        presenter?.updateView()
    }
    
    private func subViews() {
        title = "Gendre List"
        view.backgroundColor = .white
        view.addSubviews([tableView])
    }
    
    private func goToDetailGame(with indexPath: IndexPath) { }
}

extension GendreListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getGendreListCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GendreListTableViewCell",
                                                 for: indexPath) as! GendreListTableViewCell
        let row = indexPath.row
        let gendre = presenter?.getGendre(index: row)
        if let data = gendre {
            cell.setContent(with: data)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let data = presenter?.getGendre(index: row)
        let name = data?.name ?? ""
        self.presenter?.toMovieListEachGendre(with: name)
    }
}


extension GendreListViewController: BasePresenterToViewProtocol {
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
    
    func showView() {
        tableView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching News", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
