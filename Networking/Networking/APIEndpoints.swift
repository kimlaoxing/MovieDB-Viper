import Foundation

public struct APIEndpoints {
    public static func getMovies() -> Endpoint<Data> {
        return Endpoint(
            path: "genre/movie/list",
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
    
    public static func getEachListGenre(with page: Int, genres: Int) -> Endpoint<Data> {
        return Endpoint(
            path: "discover/movie",
            method: .get,
            queryParameters: [
                "page": "\(page)",
                "with_genres": "\(genres)"
            ],
            responseDecoder: RawDataResponseDecoder()
        )
    }
    
    public static func getMovieDetail(id: Int) -> Endpoint<Data> {
        return Endpoint(
            path: "movie/\(id)",
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
    
    public static func getListReviews(with id: Int, page: Int) -> Endpoint<Data> {
        return Endpoint(
            path: "movie/\(id)/reviews",
            method: .get,
            queryParameters: [ "page": "\(page)" ],
            responseDecoder: RawDataResponseDecoder()
        )
    }
    
    public static func getListTrailer(with id: Int) -> Endpoint<Data> {
        return Endpoint(
            path: "movie/\(id)/videos",
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
    
    public static func getPopularMovide(with category: String, page: Int) -> Endpoint<Data> {
        return Endpoint(
            path: "\(category)",
            method: .get,
            queryParameters: [ "page": "\(page)" ],
            responseDecoder: RawDataResponseDecoder()
        )
    }
}
