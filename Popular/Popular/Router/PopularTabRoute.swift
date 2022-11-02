import Router
import UIKit

extension PopularTabRoute where Self: Router {
    public func makePopularTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = PopularMovieViewController()
        vc.navigationItem.backButtonTitle = ""
        let presenter: ListPopularMovieViewToPresenterProtocol & ListPopularMovieInteractorToPresenterProtocol = ListPopularMoviePresenter()
        let interactor: ListPopularMoviePresenterToInteractorProtocol = ListPopularMovieInteractor()

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
        navigation.tabBarItem.title = "Popular"
        navigation.tabBarItem.image = UIImage(systemName: "list.bullet")
        navigation.navigationBar.prefersLargeTitles = false
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.backgroundColor = .gray
        return navigation
    }
}

extension DefaultRouter: PopularTabRoute { }

