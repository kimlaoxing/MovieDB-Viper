import Foundation
import Alamofire
import Components

final class MovieDetailInteractor: MovieDetailPresentorToInteractorProtocol {
    
    weak var presenter: MovieDetailInteractorToPresenterProtocol?
    var response: MovieDetailResponse?
    
    func fetchDetailMovie(with id: Int) {
        let endpoint = "\(APIService.detailBasePath)/\(id)?api_key=\(APIService.apiKey)"
        AF.request(endpoint,
                   method: .get,
                   encoding: JSONEncoding.default
        )
            .debugLog()
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieDetailResponse.self) { data in
                switch data.result {
                case .success(let data):
                    self.response = data
                    self.presenter?.MovieDetailFetched()
                case .failure:
                    self.presenter?.MovieDetailFetchedFailed()
                }
            }
    }
}
