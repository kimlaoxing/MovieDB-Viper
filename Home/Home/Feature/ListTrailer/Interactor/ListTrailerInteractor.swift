import Components
import Alamofire

final class ListTrailerInteractor: ListTrailerPresenterToInteractorProcotol {
    
    var presenter: ListTrailerInteractorToPresenterProtocol?
    
    var response: ListTrailerResponse?
    
    func fetchListTrailer(with id: Int) {
        let endpoint = "\(APIService.basePath)/movie/\(id)/videos"
        let parameter = [ "api_key" : "\(APIService.apiKey)" ]
        self.presenter?.isLoading(isLoading: true)
        AF.request(endpoint,
                   method: .get,
                   parameters: parameter,
                   encoding: URLEncoding.queryString
        )
            .debugLog()
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ListTrailerResponse.self) { data in
                self.presenter?.isLoading(isLoading: false)
                switch data.result {
                case .success(let data):
                    self.response = data
                    self.presenter?.listTrailerFetched()
                case .failure(_):
                    self.presenter?.listTrailerFetchedFailed()
                }
            }
    }
}
