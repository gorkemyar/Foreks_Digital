import UIKit

class MainPageController: UIViewController {

    let vm = StockViewModel()
    var page: Page?
    var stocks: [StockDetailed] = []
    var timer: Timer?
    
    @IBOutlet weak var stockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        stockTableView.delegate = self
        stockTableView.dataSource = self
        stockTableView.backgroundColor = UIColor.black
        
        stockTableView.register(UINib(nibName: "StockItemCell", bundle: nil), forCellReuseIdentifier: "StockItemCell")
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
                
                self.vm.getMainPageStocks(fields: nil){stocks in
                    self.stocks = stocks
                    self.stocks.sort{$0.id < $1.id}
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
        self.vm.getMainPageStocks(fields: nil){
            stocks in
            self.stocks = stocks
            self.stocks.sort{$0.id < $1.id}
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


