import Foundation
import UIKit

public protocol HomeTabRoute {
    func makeHomeTab() -> UIViewController
    func toDetailMovie(id: Int)
    func toListReviews(id: Int)
    func toMovieListGendre(gendre: Int)
    func toTrailerList(id: Int)
}

public protocol PopularTabRoute {
    func makePopularTab() -> UIViewController
}
