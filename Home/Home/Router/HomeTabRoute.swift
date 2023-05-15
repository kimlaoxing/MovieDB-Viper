import Foundation
import UIKit
import Router
import Networking

extension HomeTabRoute where Self: Router {
    public func makeHomeTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = GenreListViewController()
        vc.navigationItem.backButtonTitle = ""
        
        let presenter: BaseListViewToPresenterProtocol & BaseListInteractorToPresenterProtocol = GenreListPresenter(router: router)
        let injection = APIDataTransferDI.init()
        let interactor: BaseListPresentorToInteractorProtocol = GenreListInteractor(injection: injection)
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.root = vc
        
        let navigation = UINavigationController(rootViewController: vc)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigation.navigationBar.standardAppearance = navBarAppearance
        navigation.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigation.navigationBar.tintColor = .white
        navigation.tabBarItem.title = "Genre"
        navigation.tabBarItem.image = UIImage(systemName: "list.bullet")
        navigation.navigationBar.prefersLargeTitles = false
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.backgroundColor = .gray
        return navigation
    }
    
    func toMovieListGenre(with transition: Transition, genre: Int, genresName: String) {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = ListMovieViewController()
        vc.navigationItem.backButtonTitle = ""
        let presenter: ListMovieEachGenreViewToPresenterProtocol & ListMovieEachGenreInteractorToPresenterProtocol = ListMoviePresenter(router: router, genre: genre, genresName: genresName)
        let injection = APIDataTransferDI.init()
        let interactor: ListMovieEachGenrePresentorToInteractorProtocol = ListMovieInteractor(injection: injection)
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    func toDetailMovie(with transition: Transition, id: Int) {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = MovieDetailViewController()
        vc.navigationItem.backButtonTitle = ""
        let presenter: MovieDetailViewToPresenterProtocol & MovieDetailInteractorToPresenterProtocol = MovieDetailPresenter(router: router, id: id)
        let injection = APIDataTransferDI.init()
        let interactor: MovieDetailPresentorToInteractorProtocol = MovieDetailInteractor(injection: injection)
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    func toListReviews(with transition: Transition, id: Int) {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = ListReviewsViewController()
        vc.navigationItem.backButtonTitle = ""
        let presenter: ListReviewsViewToPresenterProtocol & ListReviewsInteractorToPresenterProtocol = ListReviewsPresenter(id: id)
        let injection = APIDataTransferDI.init()
        let interactor: ListReviewsPresentorToInteractorProtocol = ListReviewsInteractor(injection: injection)
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    func toTrailerList(with transition: Transition, id: Int) {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = ListTrailerViewController()
        let presenter: ListTrailerViewToPresenterProtocol & ListTrailerInteractorToPresenterProtocol = ListTrailerPresenter(id: id)
        let injection = APIDataTransferDI.init()
        let interactor: ListTrailerPresenterToInteractorProcotol = ListTrailerInteractor(injection: injection)
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        vc.navigationItem.backButtonTitle = ""
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
}

extension DefaultRouter: HomeTabRoute {
    public func toTrailerList(id: Int) {
        toTrailerList(with: PushTransition(), id: id)
    }
    
    public func toListReviews(id: Int) {
        toListReviews(with: ModalTransition(), id: id)
    }
    
    public func toMovieListGenre(genre: Int, genresName: String) {
        toMovieListGenre(with: PushTransition(), genre: genre, genresName: genresName)
    }
    
    public func toDetailMovie(id: Int) {
        toDetailMovie(with: PushTransition(), id: id)
    }
}
