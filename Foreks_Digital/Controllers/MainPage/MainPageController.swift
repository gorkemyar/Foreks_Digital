import UIKit

class MainPageController: UIViewController {

    let vm = StockViewModel()
    var page: Page?
    var stocks: [StockDetailed] = []
    var timer: Timer?
    
    @IBOutlet weak var stockTableView: UITableView!
    
    @IBOutlet weak var fieldButton1: UIButton!
    @IBOutlet weak var fieldButton2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldButton1.fillFieldButton(field: "field1", alignment: .right)
        fieldButton2.fillFieldButton(field: "field2", alignment: .center)
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

extension UIButton{
    func fillFieldButton(field: String, alignment: NSTextAlignment){
        //self.titleLabel?.text = field
        //self.titleLabel?.textAlignment = alignment
        //self.titleLabel?.font.withSize(1.0)

        self.setTitle(field, for: .normal)
        
        if #available(iOS 15.0, *){
            //var configuration = UIButton.Configuration.borderless()
            //configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing:5)
            
            //self.configuration?.updated(for: configuration.)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }else{
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
        

        
    }
}
