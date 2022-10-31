import Foundation
import Alamofire
import Components

class GendreListInteractor: BaseListPresentorToInteractorProtocol {
    
    weak var presenter: BaseListInteractorToPresenterProtocol?
    var gendre: [GendreResponse.Genre]?
    
    func fetchListGendre() {
        let endpoint = "\(APIService.basePath)\(APIService.listGendre)?api_key=\(APIService.apiKey)"
        print("endpoint is \(endpoint)")
        AF.request(endpoint,
                   method: .get,
                   encoding: JSONEncoding.default
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GendreResponse.self) { data in
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
