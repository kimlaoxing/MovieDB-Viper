import Components
import Alamofire

final class ListPopularMovieInteractor: ListPopularMoviePresenterToInteractorProtocol {
    
    var presenter: ListPopularMovieInteractorToPresenterProtocol?
    var response: MovieListResponse?
    
    func fetchListPopularMovie(with category: MovieCategory) {
        let endpoint = "\(APIService.basePath)\(category.rawValue)?api_key=\(APIService.apiKey)"
        let params = [ "page" : 1 ]
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
                    self.response = data
                    self.presenter?.listPopularMovieFetched()
                case .failure(_):
                    self.presenter?.listPopularMovieFetchedFailed()
                }
            }
    }
}
