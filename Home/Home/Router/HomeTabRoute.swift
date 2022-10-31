import Foundation
import UIKit
import Router

extension HomeTabRoute where Self: Router {
    public func makeHomeTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = BaseViewController()
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
    
    func toDetailMovie(with transition: Transition, id: Int) {
        print("toDetailMovie with id \(id)")
        //        let router = DefaultRouter(rootTransition: transition)
        //        let vc = DetailBaseViewController()
        //        let vm = DefaultDetailBaseViewModel(id: id)
        //        vc.viewModel = vm
        //        vc.hidesBottomBarWhenPushed = true
        //        router.root = vc
        //        route(to: vc, as: transition)
    }
}

extension DefaultRouter: HomeTabRoute {
    public func toMovieListGendre(id: Int) {
        print("toMovieListGendre with id \(id)")
    }
    
    public func toDetailMovie(id: Int) {
        print("toDetailMovie with id \(id)")
        //        toDetailMovie(with: PushTransition(), id: id)
    }
    
}
