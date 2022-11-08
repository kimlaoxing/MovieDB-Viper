import Components
import UIKit

protocol ListPopularMoviePresenterToViewProtocol: AnyObject {
    func showError()
    func showLoading(isLoading: Bool)
}

protocol ListPopularMovieInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func listPopularMovieFetchedFailed()
}

protocol ListPopularMoviePresenterToInteractorProtocol: AnyObject {
    var presenter: ListPopularMovieInteractorToPresenterProtocol? { get set }
    var totalPages: Int? { get }
    
    func fetchListPopularMovie(with category: MovieCategory, page: Int, completion: @escaping([MovieListResponse.Result]) -> Void)
}

protocol ListPopularMovieViewToPresenterProtocol: AnyObject {
    var view: ListPopularMoviePresenterToViewProtocol? { get set }
    var interactor: ListPopularMoviePresenterToInteractorProtocol? { get set }
    var currentPage: Int { get }
    var totalPage: Int? { get }
    var isLoadNextPage: Bool { get }
    var isLastPage: Bool { get }
    var response: Observable<[MovieListResponse.Result]> { get }
    
    func loadNextPage(index: Int)
    func updateView()
    func toDetailMovie(with id: Int)
}

