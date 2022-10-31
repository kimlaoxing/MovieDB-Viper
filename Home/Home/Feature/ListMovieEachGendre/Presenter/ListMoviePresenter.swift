import Foundation
import Router

final class ListMoviePresenter: ListMovieEachGendreViewToPresenterProtocol {
    var view: ListMovieEachGendrePresenterToViewProtocol?
    var interactor: ListMovieEachGendrePresentorToInteractorProtocol?
    
    private let router: Routes
    private var gendre: String
    
    typealias Routes = HomeTabRoute
    
    init(
        router: Routes,
        gendre: String
    ) {
        self.router = router
        self.gendre = gendre
    }
    
    func getResult(index: Int) -> MovieListResponse.Result? {
        let result = interactor?.response?.results?[index]
        return result
    }
    
    func getMovieListCount() -> Int? {
        return interactor?.response?.results?.count
    }
    
    func updateView() {
        interactor?.fetchListMovie(with: 1, gendres: gendre)
    }
}

extension ListMoviePresenter: ListMovieEachGendreInteractorToPresenterProtocol {
    func movieListFetched() {
        view?.showView()
    }
    
    func movieListFetchedFailed() {
        view?.showError()
    }
    
    func isLoading(isLoading: Bool) {
        view?.showLoading(isLoading: isLoading)
    }
}

