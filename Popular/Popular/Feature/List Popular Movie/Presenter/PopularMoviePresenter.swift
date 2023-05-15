import Components
import Router
import Networking

final class ListPopularMoviePresenter: ListPopularMovieViewToPresenterProtocol {

    var view: ListPopularMoviePresenterToViewProtocol?
    var interactor: ListPopularMoviePresenterToInteractorProtocol?
    
    var currentPage: Int = 1
    var totalPage: Int?
    var isLoadNextPage: Bool = false
    var isLastPage: Bool = false
    var response: Observable<[MovieListResponse.Result]> = Observable([])
    
    private let router: Routes
    
    typealias Routes = HomeTabRoute
    
    init(router: Routes) {
        self.router = router
    }
    
    func loadNextPage(index: Int) {
        let lastIndex = (self.response.value.count) - 2
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
        self.interactor?.fetchListPopularMovie(with: .popular, page: self.currentPage, completion: { data in
            if self.currentPage == 1 {
                self.isLastPage = self.currentPage == self.totalPage
                self.currentPage += 1
                self.response.value = data
            } else {
                self.isLastPage = self.currentPage == self.totalPage
                self.currentPage += 1
                var newData: [MovieListResponse.Result] = []
                newData.append(contentsOf: self.response.value)
                newData.append(contentsOf: data)
                self.response.value = newData
            }
        })
    }
    
    func toDetailMovie(with id: Int) {
        self.router.toDetailMovie(id: id)
    }
    
    func getError() -> APIError? {
        return self.interactor?.error
    }
}

extension ListPopularMoviePresenter: ListPopularMovieInteractorToPresenterProtocol {
    func isLoading(isLoading: Bool) {
        view?.showLoading(isLoading: isLoading)
    }
    
    func listPopularMovieFetchedFailed() {
        view?.showError()
    }
}
