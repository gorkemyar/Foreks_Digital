import Foundation

struct DetailedModel: Codable, Identifiable{
    var id: String {
        return key
    }
    var key: String
    var value: String
}

