import Foundation
import Router

final class GendreListPresenter: BaseListViewToPresenterProtocol {
   
    weak var view: BasePresenterToViewProtocol?
    var interactor: BaseListPresentorToInteractorProtocol?
    
    private let router: Routes
    
    typealias Routes = HomeTabRoute
    
    init(router: Routes) {
        self.router = router
    }
    
    func updateView() {
        interactor?.fetchListGendre()
    }
    
    func getGendreListCount() -> Int? {
        return interactor?.gendre?.count
    }
    
    func getGendre(index: Int) -> GendreResponse.Genre? {
        return interactor?.gendre?[index]
    }
}

extension GendreListPresenter: BaseListInteractorToPresenterProtocol {
    func isLoading(isLoading: Bool) {
        view?.showLoading(isLoading: isLoading)
    }
    
    func gendreListFetched() {
        view?.showView()
    }
    
    func genreListFetchedFailed() {
        view?.showError()
    }
}

