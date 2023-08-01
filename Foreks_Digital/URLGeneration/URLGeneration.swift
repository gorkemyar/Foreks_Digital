import Foundation

public struct URLGeneration{

    static func GetMainPageURL() -> URL{
        guard let url = URL(string:Constants.URLs.mainPage) else { fatalError("Invalid URL") }
        return url
    }

    static func GetFieldsURL(fields:[String], stockName: String) -> URL{

        var link: String = Constants.URLs.fields + Constants.URLs.fieldMarker
        for idx in 0..<fields.count{
            link += fields[idx]
            if idx != fields.count - 1{
                link += ","
            }
        }
        
        link += Constants.URLs.stockNameMarker + stockName
        
        guard let url = URL(string:link) else { fatalError("Invalid URL") }
        return url
    }
    
    
    static func GetCurrencyURL() -> URL{
        guard let url = URL(string:Constants.URLs.curreny) else { fatalError("Invalid URL") }
        return url
    }
}

