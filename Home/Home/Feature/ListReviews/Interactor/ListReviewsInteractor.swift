import Foundation
import Alamofire
import Components

final class ListReviewsInteractor: ListReviewsPresentorToInteractorProtocol {
    
    weak var presenter: ListReviewsInteractorToPresenterProtocol?
    var response: ListReviewsResponse?
    
    func fetchlistReviews(with id: Int, page: Int) {
        let endpoint = "\(APIService.basePath)/movie/\(id)/reviews"
        print("endpoint is \(endpoint)")
        let parameters: Parameters = [
            "api_key" : "\(APIService.apiKey)",
            "page": "\(page)"
        ]
        self.presenter?.isLoading(isLoading: true)
        AF.request(endpoint,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ListReviewsResponse.self) { data in
                self.presenter?.isLoading(isLoading: false)
                switch data.result {
                case .success(let data):
                    self.response = data
                    self.presenter?.listReviewsFetched()
                case .failure:
                    self.presenter?.listReviewsFetchedFailed()
                }
            }
    }
}
