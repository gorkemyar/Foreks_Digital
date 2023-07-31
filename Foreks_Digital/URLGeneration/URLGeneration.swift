import Foundation

public struct URLGeneration{
    static let baseURL = "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com/default/ForeksMobileInterviewSettings"
    static let fieldURL = "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com/default/ForeksMobileInterview"
    static let currenyURL = "https://api.genelpara.com/embed/borsa.json"
    
    
    private static let fieldMarker = "?fields="
    private static let stockNameMarker = "&stcs="
    
    static func GenerateLink(fields:[String]? = nil, stockName: String? = nil) -> URL{
        if fields == nil || stockName == nil {
            guard let url = URL(string:URLGeneration.baseURL) else { fatalError("Invalid URL") }
            return url
        }
        var link: String = URLGeneration.fieldURL + URLGeneration.fieldMarker
        
        for idx in 0..<fields!.count{
            link += fields![idx]
            if idx != fields!.count - 1{
                link += ","
            }
        }
        
        link += URLGeneration.stockNameMarker + stockName!
        
        guard let url = URL(string:link) else { fatalError("Invalid URL") }
        return url
    }
    
    
    static func GetCurrencyURL() -> URL{
        guard let url = URL(string:URLGeneration.currenyURL) else { fatalError("Invalid URL") }
        return url
    }
}

