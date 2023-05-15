import Foundation
import Networking

final class ListMovieInteractor: ListMovieEachGenrePresentorToInteractorProtocol {
    
    weak var presenter: ListMovieEachGenreInteractorToPresenterProtocol?
    var totalPages: Int?
    var error: APIError?
    
    private let DI: APIDataTransferDI
    
    init(injection: APIDataTransferDI) {
        self.DI = injection
    }
    
    func fetchListMovie(with page: Int, genres: Int, completion: @escaping ([MovieListResponse.Result]) -> Void) {
        let endpoint = APIEndpoints.getEachListGenre(with: page, genres: genres)
        self.presenter?.isLoading(isLoading: true)
        self.DI.provideApiDataTransfer().request(with: endpoint) { [weak self] result in
            guard let self else { return }
            self.presenter?.isLoading(isLoading: false)
            switch result {
            case .success(let data):
                let error = self.DI.provideErrorHandle(with: data)
                if error != nil {
                    self.error = error
                    self.presenter?.movieListFetchedFailed()
                } else {
                    let response = self.DI.provideDefaultData(type: MovieListResponse.self, with: data)
                    if let result = response.results {
                        if result.isEmpty {
                            self.presenter?.movieListIsEmpty()
                        } else {
                            self.totalPages = response.total_pages
                            completion(result)
                        }
                    }
                }
            case .failure(_):
                self.error = self.DI.provideDefaultError()
                self.presenter?.movieListFetchedFailed()
            }
        }
    }
}
