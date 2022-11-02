import Declayout
import UIKit
import Components
import Toast_Swift

final class PopularMovieViewController: UIViewController {
    
    var presenter: ListPopularMovieViewToPresenterProtocol?
    
    private lazy var tableView = UITableView.make {
        $0.edges(to: view)
        $0.delegate = self
        $0.dataSource = self
        $0.register(PopularMovieTableViewCell.self, forCellReuseIdentifier: "PopularMovieTableViewCell")
        $0.allowsMultipleSelectionDuringEditing = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.updateView()
    }
    
    private func subViews() {
        title = "Popular Movie"
        view.backgroundColor = .white
        view.addSubviews([tableView])
    }

}

extension PopularMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell",
                                                 for: indexPath) as! PopularMovieTableViewCell
        let row = indexPath.row
        if let result = presenter?.getResult() {
            cell.setContent(with: result[row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row\(indexPath.row)")
    }
}

extension PopularMovieViewController: ListPopularMoviePresenterToViewProtocol {
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
        case true:
            self.manageLoadingActivity(isLoading: true)
            self.tableView.isHidden = true
        case false:
            self.manageLoadingActivity(isLoading: false)
            self.tableView.isHidden = false
        }
    }
}
