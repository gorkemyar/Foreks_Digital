import UIKit

class TabController: UITabBarController, Coordinating {
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupTabs()
        
        self.tabBar.tintColor = Constants.colors.yellow
        self.tabBar.unselectedItemTintColor = Constants.colors.gray
        
        if #available(iOS 15.0, *) {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.backgroundColor = Constants.colors.bg
           
           self.tabBar.standardAppearance = appearance
           self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        }else{
           self.tabBar.barTintColor = Constants.colors.bg
        }
    }
    

    private func setupTabs() {
        
        let mainPage = createNavFromStoryBoard(with: "My Page", and: UIImage(systemName: "person"), name: "Main")
        let market = createNav(with: "Market", and: UIImage(systemName: "chart.xyaxis.line"), vc: MarketController())
        let news = createNav(with: "News", and: UIImage(systemName: "newspaper"), vc: NewsController())
        let exchange = createNav(with: "Exchange", and: UIImage(systemName: "dollarsign"), vc: ExchangeController())
        
        self.setViewControllers([mainPage, market, news, exchange], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
    
    private func createNavFromStoryBoard(with title: String, and image: UIImage?, name: String) -> UINavigationController{
        let storyBoard = UIStoryboard(name: name, bundle: nil)
        let vc = storyBoard.instantiateInitialViewController()
        let nav = UINavigationController(rootViewController: vc!)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
