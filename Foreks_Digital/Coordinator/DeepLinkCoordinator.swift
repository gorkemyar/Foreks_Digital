import Foundation

class DeepLinkCoordinator: DeepLinkBaseCoordinator {
    
    func handleDeeplink(deepLink: String) {
        print("")
    }
    
    var parentCoordinator: TabBarBaseCoordinator?
    
    init(tabBarBaseCoordinator: TabBarBaseCoordinator) {
        self.parentCoordinator = tabBarBaseCoordinator
    }
}
