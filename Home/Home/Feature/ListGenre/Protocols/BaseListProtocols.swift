import Foundation
import UIKit
import Networking

protocol BasePresenterToViewProtocol: AnyObject {
    func showView()
    func showError()
    func showLoading(isLoading: Bool)
}

protocol BaseListInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func genreListFetched()
    func genreListFetchedFailed()
}

protocol BaseListPresentorToInteractorProtocol: AnyObject {
    var presenter: BaseListInteractorToPresenterProtocol? { get set }
    var genre: [GenreResponse.Genre]? { get }
    var error: APIError? { get }
    
    func fetchListGenre()
}

protocol BaseListViewToPresenterProtocol: AnyObject {
    var view: BasePresenterToViewProtocol? { get set }
    var interactor: BaseListPresentorToInteractorProtocol? { get set }
    
    func updateView()
    func getGenre(index: Int) -> GenreResponse.Genre?
    func getGenreListCount() -> Int?
    func toMovieListEachGenre(with genre: Int, genresName: String)
    func getError() -> APIError?
}
