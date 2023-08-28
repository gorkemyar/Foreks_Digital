import UIKit

class MainPageCoordinator: MainPageBaseCoordinator {

    var parentCoordinator: TabBarBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    var viewModel: MainPageViewModel!
    
        
    func start() -> UIViewController {
        viewModel = MainPageViewModel(coordinator: self)
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
            goToBasketScreenWith(data: userData)
        case .changeBasketScreen:
            goToChangeBasketScreen(data: userData)
        }
    }
    
    func goToDetailScreenWith(data: [String: Any]?) {
        let detailVC = DetailPageController.instantiate(name: "Detail")
        detailVC.coordinator = self
        if (data != nil){
            detailVC.stock.value = data!["data"] as? StockDetailed
        }
        navigationRootViewController?.pushViewController(detailVC, animated: true)
    }
    
    func goToBasketScreenWith(data: [String: Any]?){
        let basketVC = BasketPageController.instantiate(name: "Basket")
        basketVC.coordinator = self
        basketVC.delegate = viewModel
        if (data != nil){
            basketVC.data = data!["data"] as? [Stock]
            basketVC.isNew = data!["isNew"] as! Bool
        }

        navigationRootViewController?.pushViewController(basketVC, animated: true)
    }
    
    func goToChangeBasketScreen(data: [String: Any]?){
        let changeVC = ChangeBasketPageController.instantiate(name: "ChangeBasket")
        changeVC.coordinator = self
        changeVC.delegate = viewModel
        if (data != nil){
            changeVC.data = data!["data"] as? Segment
        }
        
        navigationRootViewController?.pushViewController(changeVC, animated: true)
    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}

