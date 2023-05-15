import Foundation
import Router
import Components
import Networking

final class ListReviewsPresenter: ListReviewsViewToPresenterProtocol {
    
    var data: Observable<[ListReviewsResponse.Result]> = Observable([])
    var view: ListReviewsPresenterToViewProtocol?
    var interactor: ListReviewsPresentorToInteractorProtocol?
    
    var currentPage: Int = 1
    var totalPage: Int?
    var isLoadNextPage: Bool = false
    var isLastPage: Bool = false
    
    private var id: Int

    init(id: Int) {
        self.id = id
    }
    
    func loadNextPage(index: Int) {
        let lastIndex = (self.data.value.count) - 2
        self.totalPage = interactor?.totalPages ?? 0
        if currentPage <= totalPage ?? 0 {
            if !isLoadNextPage {
                if lastIndex == index {
                    updateView()
                }
            }
        }
    }
    
    func updateView() {
        interactor?.fetchlistReviews(with: id, page: 1, completion: { data in
            if self.currentPage == 1 {
                self.isLastPage = self.currentPage == self.totalPage
                self.currentPage += 1
                self.data.value = data
            } else {
                self.isLastPage = self.currentPage == self.totalPage
                self.currentPage += 1
                var newData: [ListReviewsResponse.Result] = []
                newData.append(contentsOf: self.data.value)
                newData.append(contentsOf: data)
                self.data.value = newData
            }
        })
    }
    
    func getError() -> APIError? {
        return interactor?.error
    }
}

extension ListReviewsPresenter: ListReviewsInteractorToPresenterProtocol {
    func listReviewsIsEmpty() {
        view?.showEmptyView()
    }
    
    func listReviewsFetchedFailed() {
        view?.showError()
    }
    
    func isLoading(isLoading: Bool) {
        view?.showLoading(isLoading: isLoading)
    }
    
}

