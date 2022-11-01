import Foundation
import Alamofire
import Components

final class GendreListInteractor: BaseListPresentorToInteractorProtocol {
    
    weak var presenter: BaseListInteractorToPresenterProtocol?
    var gendre: [GendreResponse.Genre]?
    
    func fetchListGendre() {
        let endpoint = "\(APIService.basePath)\(APIService.listGendre)?api_key=\(APIService.apiKey)"
        self.presenter?.isLoading(isLoading: true)
        AF.request(endpoint,
                   method: .get,
                   encoding: JSONEncoding.default
        )
            .debugLog()
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GendreResponse.self) { data in
                self.presenter?.isLoading(isLoading: false)
                switch data.result {
                case .success(let data):
                    self.gendre = data.genres
                    self.presenter?.gendreListFetched()
                case .failure:
                    self.presenter?.genreListFetchedFailed()
                }
            }
    }
}
