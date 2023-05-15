import Foundation
import Router
import Components
import Networking

final class ListMoviePresenter: ListMovieEachGenreViewToPresenterProtocol {
    var currentPage: Int = 1
    var totalPage: Int?
    var isLoadNextPage: Bool = false
    var isLastPage: Bool = false
    var response: Observable<[MovieListResponse.Result]> = Observable([])

    var view: ListMovieEachGenrePresenterToViewProtocol?
    var interactor: ListMovieEachGenrePresentorToInteractorProtocol?
    
    private let router: Routes
    private var genre: Int
    private var genresName: String
    
    typealias Routes = HomeTabRoute
    
    init(
        router: Routes,
        genre: Int,
        genresName: String
    ) {
        self.router = router
        self.genre = genre
        self.genresName = genresName
    }
    
    func getGenresName() -> String {
        return self.genresName
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
        interactor?.fetchListMovie(with: self.currentPage, genres: genre, completion: { data in
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
    
    func toMovieDetail(with id: Int) {
        self.router.toDetailMovie(id: id)
    }
    
    func getError() -> APIError? {
        return self.interactor?.error
    }
}

extension ListMoviePresenter: ListMovieEachGenreInteractorToPresenterProtocol {
    func movieListIsEmpty() {
        view?.showEmptyView()
    }
    
    func movieListFetchedFailed() {
        view?.showError()
    }
    
    func isLoading(isLoading: Bool) {
        view?.showLoading(isLoading: isLoading)
    }
}

