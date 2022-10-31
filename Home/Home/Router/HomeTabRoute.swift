import Foundation
import UIKit
import Router

extension HomeTabRoute where Self: Router {
    public func makeHomeTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = GendreListViewController()
        vc.navigationItem.backButtonTitle = ""
        
        let presenter: BaseListViewToPresenterProtocol & BaseListInteractorToPresenterProtocol = GendreListPresenter(router: router)
        let interactor: BaseListPresentorToInteractorProtocol = GendreListInteractor()
        
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
        navigation.tabBarItem.title = "Home"
        navigation.tabBarItem.image = UIImage(systemName: "house")
        navigation.navigationBar.prefersLargeTitles = false
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.backgroundColor = .gray
        return navigation
    }
    
    func toMovieListGendre(with transition: Transition, gendre: String) {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = ListMovieViewController()
        vc.navigationItem.backButtonTitle = ""
        let presenter: ListMovieEachGendreViewToPresenterProtocol & ListMovieEachGendreInteractorToPresenterProtocol = ListMoviePresenter(router: router, gendre: gendre)
        let interactor: ListMovieEachGendrePresentorToInteractorProtocol = ListMovieInteractor()
        
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
        let interactor: MovieDetailPresentorToInteractorProtocol = MovieDetailInteractor()
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
}

extension DefaultRouter: HomeTabRoute {
    public func toMovieListGendre(gendre: String) {
        toMovieListGendre(with: PushTransition(), gendre: gendre)
    }
    
    public func toDetailMovie(id: Int) {
        toDetailMovie(with: PushTransition(), id: id)
    }
    
}
