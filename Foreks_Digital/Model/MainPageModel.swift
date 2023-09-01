import Foundation

struct SearchTypes: Codable, Identifiable{
    var id: String {
        return key
    }
    let name: String
    let key: String
}

struct Page: Codable{
    let mainPageStocks: [Stock]
    let mainPageSearches: [SearchTypes]
    
    
    enum CodingKeys: String, CodingKey{
        case mainPageStocks = "mypageDefaults"
        case mainPageSearches = "mypage"
    }
}

