import Foundation

class StockViewModel: ObservableObject {
    
    private(set) var page: Page?
    private(set) var stocks: [StockDetailed] = []
    private(set) var field1: String = UserDefaults.standard.string(forKey: "field1") ?? "las"
    private(set) var field2: String = UserDefaults.standard.string(forKey: "field2") ?? "pdd"
    
    func getMainPage(completion: @escaping (Result<Page, Error>) -> Void){
        let url = URLGeneration.GetMainPageURL()
        NetworkManager.requestSession(resource: Resource<Page>(url:url)) {
            result in
            switch result{
                case .success(let data):
                    self.page = data
                case .failure:
                    print("Error: \(result)")
            }
            completion(result)
        }
    }

    func getStockDetailed(fields: [String] ,stockName: String, completion: @escaping (Result<StockDetailedHelper, Error>) -> Void){
        let url = URLGeneration.GetFieldsURL(fields: fields, stockName: stockName)
        NetworkManager.requestSession(resource: Resource<StockDetailedHelper>(url: url)) {
            result in completion(result)
        }
    }

    func getMainPageStocks(fields: [String]?, completion: @escaping ([StockDetailed]) -> Void){
        if self.page == nil{
            completion([])
            return;
        }
        let fields2: [String] = fields ?? [field1, field2]
        var arr: [StockDetailed] = []

        let dg = DispatchGroup()
        for stock:Stock in self.page!.mainPageStocks{
            dg.enter()
            self.getStockDetailed(fields: fields2, stockName: stock.tke){
                result in
                switch result{
                    case .success(let data):
                        var item = StockDetailed(stockDict: data.l[0])
                        item.changePositive = self.isChangePositive(newStock: item, fields: fields2)
                        arr.append(item)
                        dg.leave()
                        
                    case .failure(let error):
                        print("Async Task 1 Failed: \(error)")
                }
            }
        }
  
        dg.notify(queue: .main){
            arr.sort{ $0.id < $1.id }
            self.stocks = arr
            completion(arr)
        }
    }
        
    
//    func changeFields(field: String, whichField: Int) async throws{
//        do {
//
//
//            if stocks.count == 0{
//                let fields = whichField == 1 ? [field, field2] : [field1, field]
//                try await getMainPageStocks(fields: fields)
//                return
//            }
//
//            var newStocks: [StockDetailed] = []
//            for stock in stocks{
//
//                newStocks.append(stock)
//                if stock.stockDict[field] == nil {
//                    let tmpStock: StockDetailedHelper = (try await getStockDetailed(fields: [field], stockName: stock.id))!
//                    newStocks[newStocks.count-1].stockDict[field] = tmpStock.l[0][field]
//                }
//            }
//            setStocks(newStocks: newStocks)
//
//            if whichField == 1 {
//                field1 = field
//            }else{
//                field2 = field
//            }
//        }
//    }

    // Check whether new stock price is bigger
    private func isChangePositive(newStock: StockDetailed, fields:[String]) -> Bool?{
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
