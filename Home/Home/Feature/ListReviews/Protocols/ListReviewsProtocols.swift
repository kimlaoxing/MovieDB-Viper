import Components
import UIKit

protocol ListReviewsPresenterToViewProtocol: AnyObject {
    func showEmptyView()
    func showError()
    func showLoading(isLoading: Bool)
}

protocol ListReviewsInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func listReviewsIsEmpty()
    func listReviewsFetchedFailed()
}

protocol ListReviewsPresentorToInteractorProtocol: AnyObject {
    var presenter: ListReviewsInteractorToPresenterProtocol? { get set }
    var totalPages: Int? { get }
    
    func fetchlistReviews(with id: Int, page: Int, completion: @escaping ([ListReviewsResponse.Result]) -> Void)
}

protocol ListReviewsViewToPresenterProtocol: AnyObject {
    var view: ListReviewsPresenterToViewProtocol? { get set }
    var interactor: ListReviewsPresentorToInteractorProtocol? { get set }
    var data: Observable<[ListReviewsResponse.Result]> { get }
    
    var currentPage: Int { get }
    var totalPage: Int? { get }
    var isLoadNextPage: Bool { get }
    var isLastPage: Bool { get }
    
    func loadNextPage(index: Int)
    func updateView()
}
