import Declayout
import UIKit
import Components
import Toast_Swift

final class PopularMovieViewController: UIViewController {
    
    var presenter: ListPopularMovieViewToPresenterProtocol?
    var result: [MovieListResponse.Result]?
    
    private lazy var tableView = UITableView.make {
        $0.edges(to: view)
        $0.delegate = self
        $0.dataSource = self
        $0.register(PopularMovieTableViewCell.self, forCellReuseIdentifier: "PopularMovieTableViewCell")
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        presenter?.updateView()
        bind()
    }
    
    private func subViews() {
        title = "Popular Movie"
        view.backgroundColor = .white
        view.addSubviews([tableView])
    }
    
    private func bind() {
        presenter?.response.observe(on: self) { [weak self] data in
            self?.result = data
            self?.tableView.reloadData()
        }
    }
}

extension PopularMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell",
                                                 for: indexPath) as! PopularMovieTableViewCell
        let row = indexPath.row
        if let result = self.result {
            cell.setContent(with: result[row])
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            let indexPath = tableView.indexPath(for: cell)
            presenter?.loadNextPage(index: indexPath?.row ?? 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = self.result?[indexPath.row].id {
            self.presenter?.toDetailMovie(with: id)
        }
    }
}

extension PopularMovieViewController: ListPopularMoviePresenterToViewProtocol {
    
    func showError() {
        let error = self.presenter?.getError()
        let alert = UIAlertController(
            title: "Alert",
            message: "\(String(describing: error))",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(
            UIAlertAction(
                title: "Okay",
                style: UIAlertAction.Style.default,
                handler: nil
            )
        )
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
