import Foundation

class MainPageViewModel {
    
    init(){
        loadMainPage()
        startLoadingDataTimer()
        mainPageNetworkService = MainPageNetworkService()
    }
    
    private var mainPageNetworkService: MainPageNetworkService!
    
    private var timer: Timer?
    private(set) var page: Observable<Page?> = Observable(nil)
    private(set) var stocks: Observable<[StockDetailed]> = Observable([])
    private(set) var field1: Observable<String> = Observable(UserDefaults.standard.string(forKey: "field1") ?? "las")
    private(set) var field2: Observable<String> = Observable(UserDefaults.standard.string(forKey: "field2") ?? "pdd")
    

    func loadMainPage() {
        mainPageNetworkService.getMainPage() { result in
            switch result {
            case .success(let data):
                self.page.value = data
                self.loadStocks()
            case .failure(let error):
                print("Async Task 1 Failed: \(error)")
            }
        }
    }
    
    func loadStocks(){
        let fields: [String] = [self.field1.value, self.field2.value]
        self.mainPageNetworkService.getMainPageStocks(
            fields: fields,
            stocks: self.page.value?.mainPageStocks ?? [],
            sd: self.stocks.value){stocks in
                self.stocks.value = stocks
        }
    }

    @objc func loadStocksPeriodically() {
        loadStocks()
    }
    
    func startLoadingDataTimer() {
        let timeInterval: TimeInterval = 1.0
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(loadStocksPeriodically), userInfo: nil, repeats: true)
    }

    func changeField(field: String, whichField: Int){
        if whichField == 1 {
            field1.value = field
        }else{
            field2.value = field
        }
    }
}
