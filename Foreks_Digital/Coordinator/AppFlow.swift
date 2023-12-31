import Foundation

enum AppFlow {
    case main(MainScreen)
    case market(MarketScreen)
    case news(NewsScreen)
    case exchange(ExchangeScreen)
}

enum MainScreen {
    case initialScreen
    case detailScreen
    case basketScreen
    case changeBasketScreen
}
enum MarketScreen {
    case initialScreen
}
enum NewsScreen {
    case initialScreen
}
enum ExchangeScreen {
    case initialScreen
}
