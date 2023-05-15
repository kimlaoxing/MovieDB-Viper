import Foundation
import Networking
import Components

final class ListReviewsInteractor: ListReviewsPresentorToInteractorProtocol {
    
    weak var presenter: ListReviewsInteractorToPresenterProtocol?
    var totalPages: Int?
    var error: APIError?
    private let DI: APIDataTransferDI
    
    init(injection: APIDataTransferDI) {
        self.DI = injection
    }
    
    func fetchlistReviews(with id: Int, page: Int, completion: @escaping ([ListReviewsResponse.Result]) -> Void) {
        let endpoint = APIEndpoints.getListReviews(with: id, page: page)
        self.presenter?.isLoading(isLoading: true)
        self.DI.provideApiDataTransfer().request(with: endpoint) { [weak self] result in
            guard let self else { return }
            self.presenter?.isLoading(isLoading: false)
            switch result {
            case .success(let data):
                let error = self.DI.provideErrorHandle(with: data)
                if error != nil {
                    self.error = error
                    self.presenter?.listReviewsFetchedFailed()
                } else {
                    let data = self.DI.provideDefaultData(type: ListReviewsResponse.self, with: data)
                    self.totalPages = data.total_pages
                    if let result = data.results {
                        if result.count == 0 {
                            self.presenter?.listReviewsIsEmpty()
                        } else {
                            completion(result)
                        }
                    } else {
                        self.presenter?.listReviewsFetchedFailed()
                    }
                }
            case .failure(_):
                self.presenter?.listReviewsFetchedFailed()
                self.error = self.DI.provideDefaultError()
            }
        }
    }
}
