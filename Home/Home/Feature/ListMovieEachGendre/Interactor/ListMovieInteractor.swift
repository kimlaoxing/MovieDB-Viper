import Foundation
import Alamofire
import Components

final class ListMovieInteractor: ListMovieEachGendrePresentorToInteractorProtocol {
    
    weak var presenter: ListMovieEachGendreInteractorToPresenterProtocol?
    var totalPages: Int?
    
    func fetchListMovie(with page: Int, genres: Int, completion: @escaping ([MovieListResponse.Result]) -> Void) {
        let endpoint = "\(APIService.basePath)\(APIService.discover)"
        let parameters: Parameters = [
            "api_key" : "\(APIService.apiKey)",
            "page": "\(page)",
            "with_genres" : genres
        ]
        self.presenter?.isLoading(isLoading: true)
        AF.request(endpoint,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString
        )
            .debugLog()
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieListResponse.self) { data in
                self.presenter?.isLoading(isLoading: false)
                switch data.result {
                case .success(let data):
                    self.totalPages = data.total_pages
                    if let result = data.results {
                        completion(result)
                        if result.isEmpty {
                            self.presenter?.movieListIsEmpty()
                        }
                    }
                case .failure:
                    self.presenter?.movieListFetchedFailed()
                }
            }
    }
}
