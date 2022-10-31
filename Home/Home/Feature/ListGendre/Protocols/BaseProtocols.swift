import Foundation
import UIKit

protocol BasePresenterToViewProtocol: AnyObject {
    func showView()
    func showError()
}

protocol BaseListInteractorToPresenterProtocol: AnyObject {
    func gendreListFetched()
    func genreListFetchedFailed()
}

protocol BaseListPresentorToInteractorProtocol: AnyObject {
    var presenter: BaseListInteractorToPresenterProtocol? { get set }
    var gendre: [GendreResponse.Genre]? { get }
    
    func fetchListGendre()
}

protocol BaseListViewToPresenterProtocol: AnyObject {
    var view: BasePresenterToViewProtocol? { get set }
    var interactor: BaseListPresentorToInteractorProtocol? { get set }
    
    func updateView()
    func getGendre(index: Int) -> GendreResponse.Genre?
    func getGendreListCount() -> Int?
}
