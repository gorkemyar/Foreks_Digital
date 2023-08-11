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
