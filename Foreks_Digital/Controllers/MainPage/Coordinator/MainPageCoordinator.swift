import UIKit

class MainPageCoordinator: MainPageBaseCoordinator {

    var parentCoordinator: TabBarBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let vc = MainPageController.initializeVC(coordinator: self)
        rootViewController = UINavigationController(rootViewController: vc)
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .main(let screen):
            handleHomeFlow(for: screen, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }
    
    private func handleHomeFlow(for screen: MainScreen, userData: [String: Any]?) {
        switch screen {
        case .initialScreen:
            navigationRootViewController?.popToRootViewController(animated: true)
        case .detailScreen:
            goToDetailScreenWith(data: userData)
        }
    }
    
    func goToDetailScreenWith(data: [String: Any]?) {
        let detailVC = DetailPageController.initalizeVC(coordinator: self, data: data)
        navigationRootViewController?.pushViewController(detailVC, animated: true)
    }
//
//    func goToFavoritesFlow() {
//        parentCoordinator?.moveTo(flow: .orders(.firstScreen))
//    }
//
//    func goToDeepViewInFavoriteTab() {
//
//        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
//                self?.parentCoordinator?.ordersCoordinator
//                    .resetToRoot(animated: false)
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) { [weak self] in
//                self?.parentCoordinator?.ordersCoordinator
//                    .goToOrder2Screen(animated: false)
//                    .goToOrder3Screen(animated: false)
//                self?.parentCoordinator?.moveTo(flow: .orders)
//            }
//    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}

