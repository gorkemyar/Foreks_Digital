import Foundation

struct Stock: Codable, Identifiable, Hashable{
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
    func toDetailed () -> StockDetailed{
        let tmp: [String: String] = ["cod": cod, "gro": gro, "tke": tke, "def": def]
        return StockDetailed(stockDict: tmp)
    }
    static func ==(lhs:Stock, rhs:Stock) -> Bool { // Implement Equatable
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
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
