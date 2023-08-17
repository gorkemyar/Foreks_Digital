import Foundation

class MainPageViewModel {
    
    init(){
        loadMainPage()
        startLoadingDataTimer()
    }
    
    private var mainPageNetworkService: MainPageNetworkService! = MainPageNetworkService()
    
    private var timer: Timer?
    private(set) var mainPage: Observable<Page?> = Observable(nil)
    
    private(set) var field1: Observable<SearchTypes> = Observable(SearchTypes(name: "Son", key: "las"))
    private(set) var field2: Observable<SearchTypes> = Observable(SearchTypes(name: "%Fark", key: "pdd"))
    private(set) var segments: Observable<[Segment]?> = Observable(nil)
    private(set) var selectedSegment: Observable<Int> = Observable(0)

    func loadMainPage() {
        mainPageNetworkService.getMainPage() { result in
            switch result {
            case .success(let data):
                self.mainPage.value = data
                self.segments.value = [Segment(key: "Default", search: data.mainPageStocks, value: [])]
                self.loadStocks()
            case .failure(let error):
                print("Async Task 1 Failed: \(error)")
            }
        }
    }
    
    func loadStocks(){
        if segments.value == nil{
            return;
        }
        let fields: [String] = [self.field1.value.key, self.field2.value.key]
        let stocks: [Stock] = self.segments.value![self.selectedSegment.value].search
        let sd: [StockDetailed] = self.segments.value![self.selectedSegment.value].value
        
        self.mainPageNetworkService.getMainPageStocks(
            fields: fields,
            stocks: stocks,
            sd: sd){stocks in
                self.segments.value![self.selectedSegment.value].value = stocks
        }
    }

    @objc func loadStocksPeriodically() {
        loadStocks()
    }
    
    func startLoadingDataTimer() {
        let timeInterval: TimeInterval = 1.0
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(loadStocksPeriodically), userInfo: nil, repeats: true)
    }

    func changeField(field: SearchTypes, whichField: Int){
        if whichField == 1 {
            field1.value = field
        }else{
            field2.value = field
        }
    }
    
}
