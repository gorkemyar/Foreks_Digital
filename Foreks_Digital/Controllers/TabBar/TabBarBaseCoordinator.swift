import Foundation

protocol TabBarBaseCoordinator: Coordinator {
    var mainPageCoordinator: MainPageBaseCoordinator { get }
    var exchangeCoordinator: ExchangeBaseCoordinator { get }
    var marketCoordinator: MarketBaseCoordinator { get }
    var newsCoordinator: NewsBaseCoordinator { get }
    var deepLinkCoordinator: DeepLinkBaseCoordinator { get }
    func handleDeepLink(text: String)
}


protocol MainPageBaseCoordinated {
    var coordinator: MainPageBaseCoordinator? { get }
}
protocol ExchangeBaseCoordinated {
    var coordinator: ExchangeBaseCoordinator? { get }
}
protocol MarketBaseCoordinated {
    var coordinator: MarketBaseCoordinator? { get }
}
protocol NewsBaseCoordinated {
    var coordinator: NewsBaseCoordinator? { get }
}
