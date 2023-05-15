import Components
import UIKit
import Networking

protocol ListMovieEachGenrePresenterToViewProtocol: AnyObject {
    func showError()
    func showLoading(isLoading: Bool)
    func showEmptyView()
}

protocol ListMovieEachGenreInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func movieListIsEmpty()
    func movieListFetchedFailed()
}

protocol ListMovieEachGenrePresentorToInteractorProtocol: AnyObject {
    var presenter: ListMovieEachGenreInteractorToPresenterProtocol? { get set }
    var totalPages: Int? { get }
    var error: APIError? { get }
    
    func fetchListMovie(with page: Int, genres: Int, completion: @escaping([MovieListResponse.Result]) -> Void)
}

protocol ListMovieEachGenreViewToPresenterProtocol: AnyObject {
    var view: ListMovieEachGenrePresenterToViewProtocol? { get set }
    var interactor: ListMovieEachGenrePresentorToInteractorProtocol? { get set }
    var currentPage: Int { get }
    var totalPage: Int? { get }
    var isLoadNextPage: Bool { get }
    var isLastPage: Bool { get }
    var response: Observable<[MovieListResponse.Result]> { get }
    
    func loadNextPage(index: Int)
    func updateView()
    func toMovieDetail(with id: Int)
    func getGenresName() -> String
    func getError() -> APIError?
}
