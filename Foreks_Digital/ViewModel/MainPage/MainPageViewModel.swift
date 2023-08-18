import Foundation

class MainPageViewModel {
    
    init(){
        loadMainPage()
    }
    
    private var mainPageNetworkService: MainPageNetworkService! = MainPageNetworkService()
    
    private var timer: Timer?
    private(set) var mainPage: Observable<Page?> = Observable(nil)
    private(set) var currentStocks: Observable<[StockDetailed]?> = Observable(nil)
    
    private(set) var field1: Observable<SearchTypes> = Observable(SearchTypes(name: "Son", key: "las"))
    private(set) var field2: Observable<SearchTypes> = Observable(SearchTypes(name: "%Fark", key: "pdd"))
    private(set) var segments: Observable<[Segment]?> = Observable(nil)
    var selectedSegment: Int = 0

    func loadMainPage() {
        mainPageNetworkService.getMainPage() { result in
            switch result {
            case .success(let data):
                self.mainPage.value = data
                self.segments.value = [Segment(key: "Default", search: data.mainPageStocks)]
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
        let stocks: [Stock] = self.segments.value![self.selectedSegment].search
        let sd: [StockDetailed] = currentStocks.value ?? []
        
        self.mainPageNetworkService.getMainPageStocks(
            fields: fields,
            stocks: stocks,
            sd: sd){stocks in
                self.currentStocks.value = stocks
        }
    }

    @objc func loadStocksPeriodically() {
        loadStocks()
    }
    
    func startLoadingDataTimer() {
        guard timer == nil else { return }
        let timeInterval: TimeInterval = 1.0
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(loadStocksPeriodically), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
      timer?.invalidate()
      timer = nil
    }

    func changeField(field: SearchTypes, whichField: Int){
        if whichField == 1 {
            field1.value = field
        }else{
            field2.value = field
        }
    }
    
    func appendNewSegment(segment: Segment){
        segments.value?.append(segment)
    }
}
