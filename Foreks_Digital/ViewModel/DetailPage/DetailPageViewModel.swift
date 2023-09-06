import Foundation

class DetailPageViewModel{
    
    var stock: Observable<StockDetailed>
    private var field: String = "las"
    private var detailPageNetworkService: DetailPageNetworkService
    
    init(stock: StockDetailed){
        self.stock = Observable<StockDetailed>(stock)
        self.detailPageNetworkService = DetailPageNetworkService()
    }
    private var timer: Timer?
    
    
    @objc
    func loadDetailedStock(){
        detailPageNetworkService.getStockDetailed(stockName: stock.value.id, fields: [field]){
            result in
            switch result{
            case .success(let data):
                if (data.l.count > 0){
                    var item = StockDetailed(stockDict: data.l[0])
                    
                    item.changePositive = self.detailPageNetworkService.isChangePositive(stockOld: self.stock.value, newStock: item, fields: [self.field])
                    self.stock.value = item
                }
            case .failure(let error):
                print("Failed to fetch detailed stock: \(error)")
            }
        }
    }
    
    func startLoadingDataTimer() {
        guard timer == nil else { return }
        let timeInterval: TimeInterval = 0.3
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(loadDetailedStock), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
      timer?.invalidate()
      timer = nil
    }
    
    
}
