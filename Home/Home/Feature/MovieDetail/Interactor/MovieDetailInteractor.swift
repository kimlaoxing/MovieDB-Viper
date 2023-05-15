import Foundation
import Networking
import Components

final class MovieDetailInteractor: MovieDetailPresentorToInteractorProtocol {
    
    weak var presenter: MovieDetailInteractorToPresenterProtocol?
    var response: MovieDetailResponse?
    var error: APIError?
    
    private let DI: APIDataTransferDI
    
    init(injection: APIDataTransferDI) {
        self.DI = injection
    }
    
    func fetchDetailMovie(with id: Int) {
        let endpoint = APIEndpoints.getMovieDetail(id: id)
        self.presenter?.isLoading(isLoading: true)
        self.DI.provideApiDataTransfer().request(with: endpoint) { [weak self] result in
            guard let self else { return }
            self.presenter?.isLoading(isLoading: false)
            switch result {
            case .success(let data):
                if let error = self.DI.provideErrorHandle(with: data) {
                    self.error = error
                    self.presenter?.MovieDetailFetchedFailed()
                } else {
                    let response = self.DI.provideDefaultData(type: MovieDetailResponse.self, with: data)
                    self.response = response
                    self.presenter?.MovieDetailFetched()
                }
            case .failure(_):
                self.error = self.DI.provideDefaultError()
                self.presenter?.MovieDetailFetchedFailed()
            }
        }
    }
}
