import UIKit

class MainPageController: UIViewController {

    var page: Page?
    var stocks: [StockDetailed] = []
    var timer: Timer?
    
    var vm: MainPageViewModel = MainPageViewModel()
    //private let popUp = PopUpOverlay()
    private var popUp: PopUp!
    
    @IBOutlet weak var stockTableView: UITableView!
    @IBOutlet weak var barWith2Buttons: BarWith2Buttons!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillButtons()
        setButtonClick()
        
        navigationItem.hidesBackButton = true
        
        stockTableView.delegate = self
        stockTableView.dataSource = self
        stockTableView.backgroundColor = UIColor.black
        
        stockTableView.register(UINib(nibName: Constants.Identifiers.stockCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.stockCell)
        
        
        loadMainPage()
        startLoadingDataTimer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func loadMainPage() {
        vm.getMainPage() { result in
            switch result {
            case .success(let data):
                self.page = data
                
                self.vm.getMainPageStocks{stocks in
                    self.stocks = stocks
                    DispatchQueue.main.async{
                        self.stockTableView.reloadData()
                    }
                }
            case .failure(let error):
                print("Async Task 1 Failed: \(error)")
            }
        }
    }
    
    @objc func loadDataPeriodically() {
        vm.getMainPageStocks{
            stocks in
            self.stocks = stocks
            DispatchQueue.main.async{
                self.stockTableView.reloadData()
            }
        }
    }
    
    func startLoadingDataTimer() {
        let timeInterval: TimeInterval = 1.0
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(loadDataPeriodically), userInfo: nil, repeats: true)
    }
}


// BarWith2Buttons extension functions
extension MainPageController{
    func fillButtons(){
        barWith2Buttons.button1.setTitleWithPadding(field: vm.field1)
        barWith2Buttons.button2.setTitleWithPadding(field: vm.field2)
    }
    
    func setButtonClick() {
        barWith2Buttons.setClick(newClick: popupAppear)
    }
    
}

// PopUp Extensions
extension MainPageController{
    
    func popupAppear(whichField: Int, frame: CGRect) {
//            popUp.appear(sender: self, whichField: whichField, fillButtons: fillButtons)
        self.popUp = PopUp(frame: self.view.frame)
        self.popUp.backController.addTarget(self, action: #selector(outsideClick), for: .touchUpInside)
        
        self.view.addSubview(popUp)
    }
    
    
    @objc func outsideClick(){
        self.popUp.removeFromSuperview()
    }
}


extension MainPageController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if page == nil || stocks.isEmpty{
            return 0
        }else{
            return stocks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.stockCell, for: indexPath) as! StockItemCell
        let stockItem = stocks[indexPath.row]
        
        cell.fillStock(stock: stockItem, field1: vm.field1, field2: vm.field2)
        return cell
    }
}

extension MainPageController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Identifiers.segueDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? DetailPageController {
            destination.stock = stocks[(stockTableView.indexPathForSelectedRow?.row) ?? 0]
        }
    }
    
}
