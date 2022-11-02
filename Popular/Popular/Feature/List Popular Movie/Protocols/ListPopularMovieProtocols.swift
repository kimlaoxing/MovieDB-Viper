import Foundation
import UIKit

protocol ListPopularMoviePresenterToViewProtocol: AnyObject {
    func showView()
    func showError()
    func showLoading(isLoading: Bool)
}

protocol ListPopularMovieInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func listPopularMovieFetched()
    func listPopularMovieFetchedFailed()
}

protocol ListPopularMoviePresenterToInteractorProtocol: AnyObject {
    var presenter: ListPopularMovieInteractorToPresenterProtocol? { get set }
    var response: MovieListResponse? { get }
    
    func fetchListPopularMovie(with category: MovieCategory)
}

protocol ListPopularMovieViewToPresenterProtocol: AnyObject {
    var view: ListPopularMoviePresenterToViewProtocol? { get set }
    var interactor: ListPopularMoviePresenterToInteractorProtocol? { get set }
    
    func updateView()
    func getResult() -> [MovieListResponse.Result]?
    func getNumberOfCount() -> Int?
}
