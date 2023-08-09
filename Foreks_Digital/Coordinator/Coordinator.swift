import Foundation
import UIKit
enum Event{
    case pushVC(name: String)
}

protocol Coordinator{
    var navigationController: UINavigationController? {get set}
    
    func eventOccured(with type: Event) -> Any
    func start()
}

protocol Coordinating{
    var coordinator: Coordinator? {get set}
}
