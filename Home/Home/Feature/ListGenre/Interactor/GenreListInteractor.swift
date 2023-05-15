import Foundation
import Components
import Networking

final class GenreListInteractor: BaseListPresentorToInteractorProtocol {
    
    weak var presenter: BaseListInteractorToPresenterProtocol?
    var genre: [GenreResponse.Genre]?
    var error: APIError?
    private let DI: APIDataTransferDI
    
    init(injection: APIDataTransferDI) {
        self.DI = injection
    }
    
    func fetchListGenre() {
        let endpoint = APIEndpoints.getMovies()
        self.presenter?.isLoading(isLoading: true)
        DI.provideApiDataTransfer().request(with: endpoint) { [weak self] result in
            guard let self else { return }
            self.presenter?.isLoading(isLoading: false)
            switch result {
            case .success(let data):
                let error = self.DI.provideErrorHandle(with: data)
                if error != nil {
                    self.error = error
                    self.presenter?.genreListFetchedFailed()
                } else {
                    let decoder = self.DI.provideDefaultData(type: GenreResponse.self, with: data)
                    self.genre = decoder.genres
                    self.presenter?.genreListFetched()
                }
            case .failure(_):
                self.error = self.DI.provideDefaultError()
                self.presenter?.genreListFetchedFailed()
            }
            
        }
    }
}


