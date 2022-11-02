import Foundation
import UIKit
import Router
import Home
import Popular

extension SceneDelegate {
    func willConnectTo(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let mainRouter = DefaultRouter(rootTransition: ModalTransition())
        let tabs = [
            mainRouter.makeHomeTab(),
            mainRouter.makePopularTab()
        ]
        let home = TabBar(vc: tabs)
        home.selectedIndex = 0
        self.window?.rootViewController = home
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}
