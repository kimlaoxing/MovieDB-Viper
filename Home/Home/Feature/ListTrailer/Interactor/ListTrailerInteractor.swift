import Components
import Networking

final class ListTrailerInteractor: ListTrailerPresenterToInteractorProcotol {
    
    var presenter: ListTrailerInteractorToPresenterProtocol?
    var response: ListTrailerResponse?
    var error: APIError?
    private let DI: APIDataTransferDI
    
    init(injection: APIDataTransferDI) {
        self.DI = injection
    }
    
    func fetchListTrailer(with id: Int) {
        let endpoint = APIEndpoints.getListTrailer(with: id)
        self.presenter?.isLoading(isLoading: true)
        self.DI.provideApiDataTransfer().request(with: endpoint) { [weak self] result in
            guard let self else { return }
            self.presenter?.isLoading(isLoading: false)
            switch result {
            case .success(let data):
                let error = self.DI.provideErrorHandle(with: data)
                if error != nil {
                    self.error = error
                    self.presenter?.listTrailerFetchedFailed()
                } else {
                    let data = self.DI.provideDefaultData(type: ListTrailerResponse.self, with: data)
                    self.response = data
                    self.presenter?.listTrailerFetched()
                }
            case .failure(_):
                self.error = self.DI.provideDefaultError()
                self.presenter?.listTrailerFetchedFailed()
            }
        }
    }
}
