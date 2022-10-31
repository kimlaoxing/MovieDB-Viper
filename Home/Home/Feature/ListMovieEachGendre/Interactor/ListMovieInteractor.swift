import Foundation
import Alamofire
import Components

final class ListMovieInteractor: ListMovieEachGendrePresentorToInteractorProtocol {
    weak var presenter: ListMovieEachGendreInteractorToPresenterProtocol?
    var response: MovieListResponse?
    
    func fetchListMovie(with page: Int, gendres: String) {
        let endpoint = "\(APIService.basePath)\(APIService.discover)"
        print("endpoint is \(endpoint)")
        let parameters: Parameters = [
            "api_key" : "\(APIService.apiKey)",
            "sort_by" : "popularity.desc",
            "page": "\(page)",
            "with_gendres" : "\(gendres)"
        ]
        self.presenter?.isLoading(isLoading: true)
        AF.request(endpoint,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieListResponse.self) { data in
                self.presenter?.isLoading(isLoading: false)
                switch data.result {
                case .success(let data):
                    print("data is \(data)")
                    self.response = data
                    self.presenter?.movieListFetched()
                case .failure:
                    self.presenter?.movieListFetchedFailed()
                }
            }
    }
}
