import Foundation
import Alamofire
import Components

final class ListReviewsInteractor: ListReviewsPresentorToInteractorProtocol {
    
    weak var presenter: ListReviewsInteractorToPresenterProtocol?
    var totalPages: Int?
    
    func fetchlistReviews(with id: Int, page: Int, completion: @escaping ([ListReviewsResponse.Result]) -> Void) {
        let endpoint = "\(APIService.basePath)/movie/\(id)/reviews"
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
            .debugLog()
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ListReviewsResponse.self) { data in
                self.presenter?.isLoading(isLoading: false)
                switch data.result {
                case .success(let data):
                    self.totalPages = data.total_pages
                    if let result = data.results {
                        completion(result)
                    }
                    if data.results?.count == 0 {
                        self.presenter?.listReviewsIsEmpty()
                    }
                case .failure:
                    self.presenter?.listReviewsFetchedFailed()
                }
            }
    }
}
