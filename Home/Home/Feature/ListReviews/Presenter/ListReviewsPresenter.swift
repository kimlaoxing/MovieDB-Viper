import Foundation
import Router

final class ListReviewsPresenter: ListReviewsViewToPresenterProtocol {
    var view: ListReviewsPresenterToViewProtocol?
    
    var interactor: ListReviewsPresentorToInteractorProtocol?
    
    private var id: Int

    init(id: Int) {
        self.id = id
    }
    
    func getResult() -> [ListReviewsResponse.Result]? {
        let result = interactor?.response?.results
        return result
    }
    
    func updateView() {
        interactor?.fetchlistReviews(with: id, page: 1)
    }
    
    func getListCount() -> Int? {
        interactor?.response?.results?.count
    }
    
}

extension ListReviewsPresenter: ListReviewsInteractorToPresenterProtocol {
    func listReviewsFetched() {
        view?.showView()
    }
    
    func listReviewsFetchedFailed() {
        view?.showError()
    }
    
    func isLoading(isLoading: Bool) {
        view?.showLoading(isLoading: isLoading)
    }
}

