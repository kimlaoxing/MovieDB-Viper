import Declayout
import UIKit
import Components

final class GenreListViewController: UIViewController {
    
    var presenter: BaseListViewToPresenterProtocol?
    
    private lazy var tableView = UITableView.make {
        $0.edges(to: view)
        $0.delegate = self
        $0.dataSource = self
        $0.register(GenreListTableViewCell.self, forCellReuseIdentifier: "GenreListTableViewCell")
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        presenter?.updateView()
    }
    
    private func subViews() {
        title = "Genre"
        view.addSubviews([tableView])
    }
    
    private func didSelectRow(with index: IndexPath) {
        let row = index.row
        let data = presenter?.getGenre(index: row)
        let id = data?.id ?? 0
        let genresName = data?.name ?? ""
        self.presenter?.toMovieListEachGenre(with: id, genresName: genresName)
    }
}

extension GenreListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getGenreListCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreListTableViewCell",
                                                 for: indexPath) as! GenreListTableViewCell
        let row = indexPath.row
        let genre = presenter?.getGenre(index: row)
        if let data = genre {
            cell.setContent(with: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRow(with: indexPath)
    }
}


extension GenreListViewController: BasePresenterToViewProtocol {
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
        
        self.present(
            alert,
            animated: true,
            completion: nil
        )
    }
}
