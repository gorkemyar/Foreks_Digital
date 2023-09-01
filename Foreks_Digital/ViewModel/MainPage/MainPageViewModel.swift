import Foundation

class MainPageViewModel {
    
    init(coordinator: MainPageBaseCoordinator, dataService: DataService){
        self.coordinator = coordinator
        self.mainPageNetworkService = MainPageNetworkService()
        self.dataService = dataService
        self.loadSegments()
        self.loadMainPage()
        self.loadStocks(idx: 0)
    }
    
    private var coordinator: MainPageBaseCoordinator
    private var dataService: DataService
    private var mainPageNetworkService: MainPageNetworkService
    
    private var timer: Timer?
    private(set) var mainPage: Page? = nil
    
    private(set) var field1: Observable<SearchTypes> = Observable(SearchTypes(name: "Son", key: "las"))
    private(set) var field2: Observable<SearchTypes> = Observable(SearchTypes(name: "%Fark", key: "pdd"))
    private(set) var segments: Observable<[Segment]?> = Observable(nil)
    private(set) var currentStocks: Observable<[[StockDetailed]?]> = Observable([nil])
    
    private(set) var selectedSegment: Observable<Int> = Observable(0)
    
    
    func loadSegments(){
        self.segments.value = dataService.getSegments()
        self.currentStocks.value = Array(repeating: nil, count: (self.segments.value?.count ?? 0))
    }

    func loadMainPage() {
        mainPageNetworkService.getMainPage() { result in
            switch result {
            case .success(let data):
                self.mainPage = data
                if self.segments.value?.count ?? 0 == 0{
                    self.dataService.addSegment(segment: Segment(key: "Default", search: data.mainPageStocks))
                    self.loadSegments()
                }
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
}




extension MainPageViewModel: StockTableControllerDelegate{
    func goToDetailPage(indexOfCell: Int) {
        coordinator.moveTo(flow: .main(.detailScreen), userData: ["data": self.currentStocks.value[selectedSegment.value]?[indexOfCell] as Any])
    }
}

extension MainPageViewModel: BasketBarDelegate{
    func clickAddButton() {
        coordinator.moveTo(flow: .main(.basketScreen), userData: ["data": mainPage?.mainPageStocks as Any, "isNew": true as Any])
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
    func addSegment(segment: Segment, isNew: Bool) {
        if (isNew){
            self.currentStocks.value.append(nil)
            dataService.addSegment(segment: segment)
            self.loadSegments()
        }
        else{
            let key: String = segments.value![selectedSegment.value].key
            let stocks: [Stock] = self.segments.value![self.selectedSegment.value].search + segment.search
            self.currentStocks.value[self.selectedSegment.value] = nil
            self.dataService.updateSegmentStocks(key: key, stocks: stocks)
            self.loadSegments()
        }
    }
    func getStocks(isNew: Bool) -> [Stock]{
        if (isNew){
            return mainPage!.mainPageStocks
        }else{
            let currentItems: [Stock]! = segments.value![selectedSegment.value].search
            return mainPage!.mainPageStocks.filter(
                {stock in
                    return !currentItems.contains(where: {$0.id == stock.id})
                })
        }
    }
}

extension MainPageViewModel: ChangeBasketPageControllerDelegate{
    func deleteStockFromSegment(delete index: Int) {
        let key: String = segments.value![selectedSegment.value].key
        self.segments.value?[selectedSegment.value].search.remove(at: index)
        dataService.updateSegmentStocks(key: key, stocks: self.segments.value![selectedSegment.value].search)
        loadSegments()
    }
    
    func addNewStockFromBasketPage() {
        let currentItems: [Stock] = segments.value?[selectedSegment.value].search ?? []
        let data: [Stock] = mainPage!.mainPageStocks.filter({stock in
            return !currentItems.contains(where: {$0.id == stock.id})
        })
        coordinator.moveTo(flow: .main(.basketScreen), userData: ["data": data as Any, "isNew": false as Any])
    }
    
    func renameSegment(name: String) {
        let old: String = segments.value![selectedSegment.value].key
        dataService.updateSegmentName(oldName: old, newName: name)
        loadSegments()
    }
}
