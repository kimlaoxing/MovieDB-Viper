import Foundation
import Router

final class MovieDetailPresenter: MovieDetailViewToPresenterProtocol {
    var view: MovieDetailPresenterToViewProtocol?
    
    var interactor: MovieDetailPresentorToInteractorProtocol?
    
    private let router: Routes
    private var id: Int
    
    typealias Routes = HomeTabRoute
    
    init(
        router: Routes,
        id: Int
    ) {
        self.router = router
        self.id = id
    }
    
    func getResult() -> MovieDetailResponse? {
        let result = interactor?.response
        return result
    }
    
    func updateView() {
        interactor?.fetchDetailMovie(with: id)
    }
    
    func toMovieReviews(with id: Int) {
        router.toListReviews(id: id)
    }
    
    func toListTrailer(with id: Int) {
        router.toTrailerList(id: id)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorToPresenterProtocol {
    func MovieDetailFetched() {
        view?.showView()
    }
    
    func MovieDetailFetchedFailed() {
        view?.showError()
    }
    
    func isLoading(isLoading: Bool) {
        view?.showLoading(isLoading: isLoading)
    }
}

