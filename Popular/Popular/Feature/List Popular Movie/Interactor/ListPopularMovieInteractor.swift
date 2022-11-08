import Components
import Alamofire

final class ListPopularMovieInteractor: ListPopularMoviePresenterToInteractorProtocol {
    var presenter: ListPopularMovieInteractorToPresenterProtocol?
    var totalPages: Int?
    
    func fetchListPopularMovie(with category: MovieCategory, page: Int, completion: @escaping ([MovieListResponse.Result]) -> Void) {
        let endpoint = "\(APIService.basePath)\(category.rawValue)"
        let params = [ "page" : "\(page)",
                       "api_key" : "\(APIService.apiKey)"
        ]
        self.presenter?.isLoading(isLoading: true)
        AF.request(
            endpoint,
            method: .get,
            parameters: params,
            encoding: URLEncoding.queryString
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieListResponse.self) { data in
                self.presenter?.isLoading(isLoading: false)
                switch data.result {
                case .success(let data):
                    self.totalPages = data.total_pages
                    if let result = data.results {
                        completion(result)
                    }
                case .failure(_):
                    self.presenter?.listPopularMovieFetchedFailed()
                }
            }
    }
}
