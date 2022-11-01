import Foundation
import UIKit

protocol MovieDetailPresenterToViewProtocol: AnyObject {
    func showView()
    func showError()
    func showLoading(isLoading: Bool)
}

protocol MovieDetailInteractorToPresenterProtocol: AnyObject {
    func isLoading(isLoading: Bool)
    func MovieDetailFetched()
    func MovieDetailFetchedFailed()
}

protocol MovieDetailPresentorToInteractorProtocol: AnyObject {
    var presenter: MovieDetailInteractorToPresenterProtocol? { get set }
    var response: MovieDetailResponse? { get }
    
    func fetchDetailMovie(with id: Int)
}

protocol MovieDetailViewToPresenterProtocol: AnyObject {
    var view: MovieDetailPresenterToViewProtocol? { get set }
    var interactor: MovieDetailPresentorToInteractorProtocol? { get set }
    
    func updateView()
    func getResult() -> MovieDetailResponse?
    func toMovieReviews(with id: Int)
    func toListTrailer(with id: Int)
}
