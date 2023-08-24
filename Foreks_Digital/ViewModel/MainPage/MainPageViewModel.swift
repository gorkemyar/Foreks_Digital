import Foundation

class MainPageViewModel {
    
    init(coordinator: MainPageBaseCoordinator){
        self.coordinator = coordinator
        loadMainPage()
    }
    
    private var coordinator: MainPageBaseCoordinator
    private var mainPageNetworkService: MainPageNetworkService! = MainPageNetworkService()
    
    private var timer: Timer?
    private(set) var mainPage: Observable<Page?> = Observable(nil)
    private(set) var currentStocks: Observable<[[StockDetailed]?]> = Observable([nil])
    
    private(set) var field1: Observable<SearchTypes> = Observable(SearchTypes(name: "Son", key: "las"))
    private(set) var field2: Observable<SearchTypes> = Observable(SearchTypes(name: "%Fark", key: "pdd"))
    private(set) var segments: Observable<[Segment]?> = Observable(nil)
    private(set) var selectedSegment: Observable<Int> = Observable(0)
    private(set) var segmentEditing: Observable<Bool> = Observable(false)
    

    func loadMainPage() {
        mainPageNetworkService.getMainPage() { result in
            switch result {
            case .success(let data):
                self.mainPage.value = data
                self.segments.value = [Segment(key: "Default", search: data.mainPageStocks)]
                self.loadStocks(idx: 0)
            case .failure(let error):
                print("Async Task 1 Failed: \(error)")
            }
        }
    }
    
    func loadStocks(idx: Int){
        if segments.value == nil{
            return;
        }
        let fields: [String] = [field1.value.key, field2.value.key]
        let stocks: [Stock] = segments.value![idx].search
        let sd: [StockDetailed] = currentStocks.value[idx] ?? []
        
        mainPageNetworkService.getMainPageStocks(
            fields: fields,
            stocks: stocks,
            sd: sd){stocks in
                self.currentStocks.value[idx] = stocks
        }
    }

    @objc func loadStocksPeriodically(sender: Timer) {
        loadStocks(idx: (sender.userInfo as! [String: Int])["idx"]!)
    }
    
    func startLoadingDataTimer() {
        guard timer == nil else { return }
        let timeInterval: TimeInterval = 1.0
        let userInfo = ["idx": self.selectedSegment.value]
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(loadStocksPeriodically(sender:)), userInfo: userInfo, repeats: true)
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

extension MainPageViewModel: StockTableControllerDelegate{
    func goToDetailPage(indexOfCell: Int) {
        coordinator.moveTo(flow: .main(.detailScreen), userData: ["data": self.currentStocks.value[selectedSegment.value]?[indexOfCell] as Any])
    }
}

extension MainPageViewModel: BasketBarDelegate{
    func clickAddButton() {
        coordinator.moveTo(flow: .main(.basketScreen), userData: ["data": mainPage.value?.mainPageStocks as Any])
    }
    func clickChangeButton() {
        coordinator.moveTo(flow: .main(.changeBasketScreen), userData: ["data": segments.value?[selectedSegment.value] as Any])
    }
    
    func changeSegment(index: Int){
        self.stopTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            self.selectedSegment.value = index
            self.startLoadingDataTimer()
        }
    }
}

extension MainPageViewModel: BasketPageDelegate{
    func addSegment(segment: Segment) {
        self.currentStocks.value.append(nil)
        self.appendNewSegment(segment: segment)
    }
}

extension MainPageViewModel: ChangeBasketPageControllerDelegate{
    func deleteStockFromSegment(delete index: Int) {
        self.segments.value?[selectedSegment.value].search.remove(at: index)
    }
}
