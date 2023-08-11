import UIKit

class TabBarCoordinator: TabBarBaseCoordinator {

    var parentCoordinator: TabBarBaseCoordinator?
    
    lazy var mainPageCoordinator: MainPageBaseCoordinator = MainPageCoordinator()
    lazy var exchangeCoordinator: ExchangeBaseCoordinator = ExchangeCoordinator()
    lazy var marketCoordinator: MarketBaseCoordinator = MarketCoordinator()
    lazy var newsCoordinator: NewsBaseCoordinator = NewsCoordinator()
    
    lazy var rootViewController: UIViewController = UITabBarController()
    
    func start() -> UIViewController {
        
        let mainPageController = mainPageCoordinator.start()
        mainPageCoordinator.parentCoordinator = self
        mainPageController.tabBarItem = UITabBarItem(title: "My Page", image: UIImage(systemName: "person"), tag: 0)
        
        let marketController = marketCoordinator.start()
        marketCoordinator.parentCoordinator = self
        marketController.tabBarItem = UITabBarItem(title: "Market", image: UIImage(systemName: "chart.xyaxis.line"), tag: 1)
        
        let newsController = newsCoordinator.start()
        newsCoordinator.parentCoordinator = self
        newsController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 2)
        
        let exchangeController = exchangeCoordinator.start()
        exchangeCoordinator.parentCoordinator = self
        exchangeController.tabBarItem = UITabBarItem(title: "Exchange", image: UIImage(systemName: "dollarsign"), tag: 3)
        
        
        (rootViewController as? UITabBarController)?.viewControllers = [mainPageController,marketController, newsController, exchangeController]
        
        (rootViewController as? UITabBarController)?.tabBar.tintColor = Constants.colors.yellow
        (rootViewController as? UITabBarController)?.tabBar.unselectedItemTintColor = Constants.colors.gray
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Constants.colors.bg

            (rootViewController as? UITabBarController)?.tabBar.standardAppearance = appearance
            (rootViewController as? UITabBarController)?.tabBar.scrollEdgeAppearance = (rootViewController as? UITabBarController)?.tabBar.standardAppearance
        }else{
            (rootViewController as? UITabBarController)?.tabBar.barTintColor = Constants.colors.bg
        }
                
        return rootViewController
    }
        
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .main:
            goToMainPageFlow(flow)
        case .market:
            goToMarketFlow(flow)
        case .news:
            goToNewsFlow(flow)
        case .exchange:
            goToExchangeFlow(flow)
        }
    }
    
    private func goToMainPageFlow(_ flow: AppFlow) {
        mainPageCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
    }
    private func goToMarketFlow(_ flow: AppFlow) {
        marketCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }
    private func goToNewsFlow(_ flow: AppFlow) {
        newsCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
    private func goToExchangeFlow(_ flow: AppFlow) {
        exchangeCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 3
    }
    
    func resetToRoot() -> Self {
        mainPageCoordinator.resetToRoot(animated: false)
        moveTo(flow: .main(.initialScreen), userData: nil)
        return self
    }
    
}
