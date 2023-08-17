import UIKit

class MainPageCoordinator: MainPageBaseCoordinator {

    var parentCoordinator: TabBarBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    let viewModel = MainPageViewModel()
    
    
    func start() -> UIViewController {
        let vc = MainPageController.instantiate(name: "Main")
        vc.viewModel = viewModel
        vc.coordinator = self
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
        case .basketScreen:
            goToBasketScreen(data: userData)
        }
    }
    
    func goToDetailScreenWith(data: [String: Any]?) {
        let detailVC = DetailPageController.instantiate(name: "Detail")
        detailVC.coordinator = self
        if (data != nil){
            detailVC.stock.value = data!["stock"] as? StockDetailed
        }
        navigationRootViewController?.pushViewController(detailVC, animated: true)
    }
    
    func goToBasketScreen(data: [String: Any]?){
        let basketVC = BasketPageController.instantiate(name: "Basket")
        basketVC.coordinator = self
        basketVC.viewModel = viewModel
        navigationRootViewController?.pushViewController(basketVC, animated: true)
    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}

