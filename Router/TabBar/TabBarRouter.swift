//
//  TabBarRouter.swift
//  Router
//
//  Created by Kevin Maulana on 31/10/22.
//

import Foundation
import UIKit

public protocol HomeTabRoute {
    func makeHomeTab() -> UIViewController
    func toDetailMovie(id: Int)
    func toListReviews(id: Int)
    func toMovieListGendre(gendre: Int)
    func toTrailerList(id: Int)
}
