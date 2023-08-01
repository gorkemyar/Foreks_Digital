import UIKit

class MainPageController: UIViewController {

    var page: Page?
    var stocks: [StockDetailed] = []
    var timer: Timer?
    
    private let popUp = PopUpOverlay()
    
    @IBOutlet weak var stockTableView: UITableView!
    @IBOutlet weak var fieldButton1: UIButton!
    @IBOutlet weak var fieldButton2: UIButton!
    
    @IBAction func fieldButton(_ sender: UIButton) {
        let whichField = sender.currentTitle == MainPageViewModel.shared.field1 ? 1 : 2
        popUp.appear(sender: self, whichField: whichField, fillButtons: fillButtons)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillButtons()
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
        MainPageViewModel.shared.getMainPage() { result in
            switch result {
            case .success(let data):
                self.page = data
                
                MainPageViewModel.shared.getMainPageStocks{stocks in
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
        MainPageViewModel.shared.getMainPageStocks{
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

extension UIButton{
    func fillFieldButton(field: String, alignment: NSTextAlignment){
        self.setTitle(field, for: .normal)
        
        if #available(iOS 15.0, *){
            //var configuration = UIButton.Configuration.borderless()
            //configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing:5)
            
            //self.configuration?.updated(for: configuration.)
            self.contentEdgeInsets = Constants.edgeInsets.leftRight5
        }else{
            self.contentEdgeInsets = Constants.edgeInsets.leftRight5
        } 
    }
}

extension MainPageController{
    func fillButtons(){
        fieldButton1.fillFieldButton(field: MainPageViewModel.shared.field1, alignment: .right)
        fieldButton2.fillFieldButton(field: MainPageViewModel.shared.field2, alignment: .center)
    }
}
