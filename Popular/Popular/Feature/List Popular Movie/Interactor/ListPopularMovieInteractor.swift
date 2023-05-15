import Components
import Networking

final class ListPopularMovieInteractor: ListPopularMoviePresenterToInteractorProtocol {
    var presenter: ListPopularMovieInteractorToPresenterProtocol?
    var totalPages: Int?
    var error: APIError?
    private let DI: APIDataTransferDI
    
    init(injection: APIDataTransferDI) {
        self.DI = injection
    }
    
    func fetchListPopularMovie(with category: MovieCategory, page: Int, completion: @escaping ([MovieListResponse.Result]) -> Void) {
        self.presenter?.isLoading(isLoading: true)
        let endpoint = APIEndpoints.getPopularMovide(with: category.rawValue, page: page)
        self.DI.provideApiDataTransfer().request(with: endpoint) { [weak self] result in
            guard let self else { return }
            self.presenter?.isLoading(isLoading: false)
            switch result {
            case .success(let data):
                if let error = self.DI.provideErrorHandle(with: data) {
                    self.error = error
                    self.presenter?.listPopularMovieFetchedFailed()
                } else {
                    let response = self.DI.provideDefaultData(type: MovieListResponse.self, with: data)
                    if let data = response.results {
                        completion(data)
                        self.totalPages = response.total_pages
                    }
                }
            case .failure(_):
                self.error = self.DI.provideDefaultError()
                self.presenter?.listPopularMovieFetchedFailed()
            }
        }
    }
}
