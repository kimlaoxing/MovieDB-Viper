import Foundation
import UIKit

protocol ListMovieEachGendrePresenterToViewProtocol: AnyObject {
    func showView()
    func showError()
    func showLoading(isLoading: Bool)
}

protocol ListMovieEachGendreInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func movieListFetched()
    func movieListFetchedFailed()
}

protocol ListMovieEachGendrePresentorToInteractorProtocol: AnyObject {
    var presenter: ListMovieEachGendreInteractorToPresenterProtocol? { get set }
    var response: MovieListResponse? { get }
    
    func fetchListMovie(with page: Int, gendres: String)
}

protocol ListMovieEachGendreViewToPresenterProtocol: AnyObject {
    var view: ListMovieEachGendrePresenterToViewProtocol? { get set }
    var interactor: ListMovieEachGendrePresentorToInteractorProtocol? { get set }
    
    func updateView()
    func getResult(index: Int) -> MovieListResponse.Result?
    func getMovieListCount() -> Int?
}
