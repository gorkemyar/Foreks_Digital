import Foundation

class StockViewModel: ObservableObject {
    
    private(set) var page: Page?
    private(set) var stocks: [StockDetailed] = []
    private(set) var field1: String = UserDefaults.standard.string(forKey: "field1") ?? "las"
    private(set) var field2: String = UserDefaults.standard.string(forKey: "field2") ?? "pdd"
    
    func getMainPage(completion: @escaping (Result<Page, Error>) -> Void){
        let url = URLGeneration.GenerateLink()
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
        let url = URLGeneration.GenerateLink(fields: fields, stockName: stockName)
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
                        item.changePositive = self.isChangePositive(newStock: item, idx: arr.count, fields: fields2)
                        arr.append(item)
                        dg.leave()
                        
                    case .failure(let error):
                        print("Async Task 1 Failed: \(error)")
                }
            }
        }
        dg.notify(queue: .main){
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

    private func isChangePositive(newStock: StockDetailed, idx: Int, fields:[String]) -> Bool?{
        var changePositive: Bool? = nil

        let f1: String = fields[0];
        let f2: String = fields[1];

        if stocks.count > idx{
            changePositive = stocks[idx].stockDict[f1] != nil
                            && newStock.stockDict[f1] != nil ?
            stocks[idx].stockDict[f1]! < newStock.stockDict[f1]!
                                : changePositive


            changePositive = stocks[idx].stockDict[f2] != nil
                             && newStock.stockDict[f2] != nil ?
                                stocks[idx].stockDict[f2]! < newStock.stockDict[f2]!
                                || changePositive == true
                                : changePositive
        }
        
        return changePositive
    }
    
}
