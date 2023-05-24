import Networking

final class ListTrailerPresenter: ListTrailerViewToPresenterProtocol {
    
    var view: ListTrailerPresenterToViewProtocol?
    var interactor: ListTrailerPresenterToInteractorProcotol?
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func updateView() {
        self.interactor?.fetchListTrailer(with: id)
    }
    
    func getResult() -> [ListTrailerResponse.Result]? {
        return self.interactor?.response?.results
    }
    
    func getNumberOfCount() -> Int? {
        return interactor?.response?.results?.count
    }
    
    func getError() -> APIError? {
        return interactor?.error
    }
}

extension ListTrailerPresenter: ListTrailerInteractorToPresenterProtocol {
    func listTrailerIsEmpty() {
        view?.showEmptyView()
    }
    
    func isLoading(isLoading: Bool) {
        view?.showLoading(isLoading: isLoading)
    }
    
    func listTrailerFetched() {
        view?.showView()
    }
    
    func listTrailerFetchedFailed() {
        view?.showError()
    }
}
