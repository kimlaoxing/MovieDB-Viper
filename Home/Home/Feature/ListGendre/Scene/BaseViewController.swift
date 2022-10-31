import Declayout
import UIKit
import Components

final class BaseViewController: UIViewController {
    
    var presenter: BaseListViewToPresenterProtocol?
    
    private lazy var emptyView = EmptyDataView.make {
        $0.center(to: view)
        $0.title.text = "Gendre List is Empty."
        $0.title.font = .systemFont(ofSize: 12, weight: .bold)
        $0.title.numberOfLines = 0
        $0.button.isHidden = true
        $0.image.image = UIImage(systemName: "nosign")
        $0.image.width(100)
        $0.image.tintColor = .black
    }
    
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
        view.addSubviews([tableView])
//        view.addSubviews([emptyView])
    }
    
//    private func handleState(with state: BaseViewState) {
//        switch state {
//        case .loading:
//            self.tableView.isHidden = true
//            self.emptyView.isHidden = true
//        case .normal:
//            self.tableView.isHidden = false
//            self.emptyView.isHidden = true
//        case .empty:
//            self.tableView.isHidden = true
//            self.emptyView.isHidden = false
//        }
//    }
    
    private func goToDetailGame(with indexPath: IndexPath) { }
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getGendreListCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GendreListTableViewCell",
                                                 for: indexPath) as! GendreListTableViewCell
        let row = indexPath.row
        let news = presenter?.getGendre(index: row)
        if let data = news {
            print("data is \(data)")
            cell.setContent(with: data)
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("your id is")
    }
}


extension BaseViewController: BasePresenterToViewProtocol {
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
