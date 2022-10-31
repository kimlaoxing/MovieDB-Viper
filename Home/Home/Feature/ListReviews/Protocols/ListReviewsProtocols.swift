import Foundation
import UIKit

protocol ListReviewsPresenterToViewProtocol: AnyObject {
    func showView()
    func showError()
    func showLoading(isLoading: Bool)
}

protocol ListReviewsInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func listReviewsFetched()
    func listReviewsFetchedFailed()
}

protocol ListReviewsPresentorToInteractorProtocol: AnyObject {
    var presenter: ListReviewsInteractorToPresenterProtocol? { get set }
    var response: ListReviewsResponse? { get }
    
    func fetchlistReviews(with id: Int, page: Int)
}

protocol ListReviewsViewToPresenterProtocol: AnyObject {
    var view: ListReviewsPresenterToViewProtocol? { get set }
    var interactor: ListReviewsPresentorToInteractorProtocol? { get set }
    
    func updateView()
    func getResult() -> ListReviewsResponse?
}
