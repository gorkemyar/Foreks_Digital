import UIKit

protocol Storyboardable {
    static var storyboardIdentifier: String { get }

    static func instantiate(name: String) -> Self

}

extension Storyboardable where Self: UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: self)
    }

    static func instantiate(name: String) -> Self {
        guard let viewController = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("Unable to Instantiate View Controller With Storyboard Identifier \(storyboardIdentifier)")
        }

        return viewController
    }

}
