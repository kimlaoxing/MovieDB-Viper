import Components
import UIKit

protocol ListMovieEachGendrePresenterToViewProtocol: AnyObject {
    func showError()
    func showLoading(isLoading: Bool)
    func showEmptyView()
}

protocol ListMovieEachGendreInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func movieListIsEmpty()
    func movieListFetchedFailed()
}

protocol ListMovieEachGendrePresentorToInteractorProtocol: AnyObject {
    var presenter: ListMovieEachGendreInteractorToPresenterProtocol? { get set }
    var totalPages: Int? { get }
    
    func fetchListMovie(with page: Int, genres: Int, completion: @escaping([MovieListResponse.Result]) -> Void)
}

protocol ListMovieEachGendreViewToPresenterProtocol: AnyObject {
    var view: ListMovieEachGendrePresenterToViewProtocol? { get set }
    var interactor: ListMovieEachGendrePresentorToInteractorProtocol? { get set }
    var currentPage: Int { get }
    var totalPage: Int? { get }
    var isLoadNextPage: Bool { get }
    var isLastPage: Bool { get }
    var response: Observable<[MovieListResponse.Result]> { get }
    
    func loadNextPage(index: Int)
    func updateView()
    func toMovieDetail(with id: Int)
    func getGenresName() -> String
}
