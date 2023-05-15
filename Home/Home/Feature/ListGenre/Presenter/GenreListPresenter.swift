import Foundation
import Router
import Networking

final class GenreListPresenter: BaseListViewToPresenterProtocol {
    
    weak var view: BasePresenterToViewProtocol?
    var interactor: BaseListPresentorToInteractorProtocol?
    
    private let router: Routes
    
    typealias Routes = HomeTabRoute
    
    init(router: Routes) {
        self.router = router
    }
    
    func updateView() {
        interactor?.fetchListGenre()
    }
    
    func getGenreListCount() -> Int? {
        return interactor?.genre?.count
    }
    
    func getGenre(index: Int) -> GenreResponse.Genre? {
        return interactor?.genre?[index]
    }
    
    func toMovieListEachGenre(with genre: Int, genresName: String) {
        self.router.toMovieListGenre(genre: genre, genresName: genresName)
    }

    func getError() -> APIError? {
        return interactor?.error
    }
}

extension GenreListPresenter: BaseListInteractorToPresenterProtocol {
    func isLoading(isLoading: Bool) {
        view?.showLoading(isLoading: isLoading)
    }
    
    func genreListFetched() {
        view?.showView()
    }
    
    func genreListFetchedFailed() {
        view?.showError()
    }
}

