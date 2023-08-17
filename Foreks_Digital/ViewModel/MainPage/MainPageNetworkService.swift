import Foundation

final class MainPageNetworkService{
    
    
    
    func getMainPage(completion: @escaping (Result<Page, Error>) -> Void){
        let url = URLGeneration.GetMainPageURL()
        NetworkManager.requestSession(resource: Resource<Page>(url:url)) {
            result in
            completion(result)
        }
    }
    
    func getStockDetailed(stockName: String, fields: [String]  ,completion: @escaping (Result<StockDetailedHelper, Error>) -> Void){
        let url = URLGeneration.GetFieldsURL(fields: fields, stockName: stockName)
        NetworkManager.requestSession(resource: Resource<StockDetailedHelper>(url: url)) {
            result in completion(result)
        }
    }
    
    
    func getMainPageStocks(fields: [String], stocks: [any Identifiable], sd: [StockDetailed], completion: @escaping ([StockDetailed]) -> Void){
        
        var arr: [StockDetailed] = []
        let dg = DispatchGroup()
        for stock in stocks{
            dg.enter()
            self.getStockDetailed(stockName: stock.id as! String, fields: fields){
                result in
                switch result{
                    case .success(let data):
                    if data.l.count > 0{
                        var item = StockDetailed(stockDict: data.l[0])
                        item.changePositive = self.isChangePositive(stocks: sd, newStock: item, fields: fields)
                        arr.append(item)
                    }
                    
                    dg.leave()
                    case .failure(let error):
                        print("Async Task 1 Failed: \(error)")
                }
            }
        }
  
        dg.notify(queue: .main){
            arr.sort{ $0.id < $1.id }
            completion(arr)
        }
    }
    
    private func isChangePositive(stocks: [StockDetailed], newStock: StockDetailed, fields:[String]) -> Bool?{
        let idx = stocks.firstIndex(where: {$0.id == newStock.id})
        if idx == nil{return nil}
        
        let f1: String = fields[0];
        let f2: String = fields[1];
        var changePositive: Bool? = stocks[idx!].changePositive
        
        // Check existence of the fields and decide whether the current is bigger or later
        if stocks[idx!].stockDict[f1] != nil && newStock.stockDict[f1] != nil {
            if stocks[idx!].stockDict[f1]! < newStock.stockDict[f1]!{
                changePositive = true
            }
            else if stocks[idx!].stockDict[f1]! > newStock.stockDict[f1]!{
                changePositive = false
            }
        }
        
        if stocks[idx!].stockDict[f2] != nil && newStock.stockDict[f2] != nil {
            if stocks[idx!].stockDict[f2]! < newStock.stockDict[f2]!{
                changePositive = true
            }
            else if stocks[idx!].stockDict[f2]! > newStock.stockDict[f2]!{
                changePositive = false
            }
        }
        
        return changePositive
    }
    
}
