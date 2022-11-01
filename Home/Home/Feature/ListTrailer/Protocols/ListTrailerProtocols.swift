import Foundation
import UIKit

protocol ListTrailerPresenterToViewProtocol: AnyObject {
    func showView()
    func showError()
    func showLoading(isLoading: Bool)
}

protocol ListTrailerInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func listTrailerFetched()
    func listTrailerFetchedFailed()
}

protocol ListTrailerPresenterToInteractorProcotol: AnyObject {
    var presenter: ListTrailerInteractorToPresenterProtocol? { get set }
    var response: ListTrailerResponse? { get }
    
    func fetchListTrailer(with id: Int)
}

protocol ListTrailerViewToPresenterProtocol: AnyObject {
    var view: ListTrailerPresenterToViewProtocol? { get set }
    var interactor: ListTrailerPresenterToInteractorProcotol? { get set }
    
    func updateView()
    func getResult() -> [ListTrailerResponse.Result]?
    func getNumberOfCount() -> Int?
}
