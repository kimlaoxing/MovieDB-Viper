import Foundation
import UIKit
import Networking

protocol ListTrailerPresenterToViewProtocol: AnyObject {
    func showView()
    func showError()
    func showLoading(isLoading: Bool)
    func showEmptyView()
}

protocol ListTrailerInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func listTrailerFetched()
    func listTrailerFetchedFailed()
    func listTrailerIsEmpty()
}

protocol ListTrailerPresenterToInteractorProcotol: AnyObject {
    var presenter: ListTrailerInteractorToPresenterProtocol? { get set }
    var response: ListTrailerResponse? { get }
    var error: APIError? { get }
    
    func fetchListTrailer(with id: Int)
}

protocol ListTrailerViewToPresenterProtocol: AnyObject {
    var view: ListTrailerPresenterToViewProtocol? { get set }
    var interactor: ListTrailerPresenterToInteractorProcotol? { get set }
    
    func updateView()
    func getResult() -> [ListTrailerResponse.Result]?
    func getNumberOfCount() -> Int?
    func getError() -> APIError?
}
