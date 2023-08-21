import Foundation



struct Stock: Codable, Identifiable{
    var id: String {
        return tke
    }
    let gro: String
    let cod: String
    let tke: String
    let def: String
    
    func copy() -> Stock{
        return Stock(gro: gro, cod: cod, tke: tke, def: def)
    }
}

struct StockDetailed: Codable, Identifiable{
    var id: String {
        return stockDict["tke"]!
    }
    var stockDict: [String:String]
    var changePositive: Bool?
}

struct StockDetailedHelper: Codable{
    let l: [[String:String]]
    let z: String
}

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

struct Segment{
    let key: String
    let search: [Stock]
}
