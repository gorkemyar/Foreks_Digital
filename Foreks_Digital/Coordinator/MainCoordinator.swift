import Foundation
import UIKit

class MainCoordinator: Coordinator{
    
    var navigationController: UINavigationController?
    
    func eventOccured(with type: Event) -> Any{
        switch type {
        case .pushVC(let name):
            let vc: UIViewController? = navigationController?.pushController(name: name)
            if vc != nil{
                return vc!
            }
        }
        return 0
    }
    
    func start() {
        var vc: UIViewController & Coordinating = TabController()
        vc.coordinator = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.setViewControllers([vc], animated: false)        
    }
}
