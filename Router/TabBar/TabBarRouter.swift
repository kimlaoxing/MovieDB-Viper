import Foundation
import UIKit

public protocol HomeTabRoute {
    func makeHomeTab() -> UIViewController
    func toDetailMovie(id: Int)
    func toListReviews(id: Int)
    func toMovieListGenre(genre: Int, genresName: String)
    func toTrailerList(id: Int)
}

public protocol PopularTabRoute {
    func makePopularTab() -> UIViewController
}
