import UIKit

class BasketPageController: UIViewController, MainPageBaseCoordinated , Storyboardable{

    
    var isNew: Bool = true
    weak var delegate: BasketPageDelegate?
    weak var coordinator: MainPageBaseCoordinator?
    private var segmentNamePopUp: SegmentNamePopUp!
    var data: [Stock]?
    
    var stockList: [Stock] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBAction func createList(_ sender: Any) {
        if (isNew){
            segmentNamePopUpAppear()
        }else{
            createSegment(name: "dummy")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    
    func setup(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.black
        tableView.register(UINib(nibName: Constants.Identifiers.basketCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.basketCell)
        self.createButton.isEnabled = false
        
        if (isNew){
            self.createButton.setTitle("Create New Basket", for: .normal)
        }else{
            self.createButton.setTitle("Add Stocks", for: .normal)
        }
        
    }
    
    func loadData(){
        DispatchQueue.main.async {
            print("helloooo")
            self.data = self.delegate?.getStocks(isNew: self.isNew)
            self.tableView.reloadData()
        }

    }
}
extension BasketPageController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.basketCell, for: indexPath) as! BasketCell
        let stockItem = data![indexPath.row]
        
        cell.fillStock(stock: stockItem)
        cell.add = {[weak self] stock in
            self?.addStock(stock: stock)
        }
        cell.remove = {[weak self] stock in
            self?.removeStock(stock: stock)
        }
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        return cell
    }
}

extension BasketPageController{
    func addStock(stock: Stock){
        stockList.append(stock)
        self.createButton.isEnabled = true
    }
    func removeStock(stock: Stock){
        let idx = stockList.firstIndex(where: {$0.cod == stock.cod})
        if idx != nil{
            stockList.remove(at: idx!)
        }
        if (stockList.count == 0){
            self.createButton.isEnabled = false
        }
    }
}

extension BasketPageController{
    func segmentNamePopUpAppear(){
        self.segmentNamePopUp = SegmentNamePopUp(frame: self.view.frame)
        
        self.segmentNamePopUp.buttonClick = {
            [weak self] name in self?.createSegment(name: name)
        }
        self.segmentNamePopUp.backController.addTarget(self, action: #selector(outsideClick), for: .touchUpInside)
        self.view.addSubview(segmentNamePopUp)
    }
    
    @objc func outsideClick(){
        self.segmentNamePopUp.removeFromSuperview()
    }
    
    func createSegment(name: String){
        let segment: Segment = Segment(key: name, search: stockList)
        delegate?.addSegment(segment: segment, isNew: self.isNew)
        stockList = []
        coordinator?.resetToRoot(animated: true)
    }
}


protocol BasketPageDelegate: AnyObject{
    func addSegment(segment: Segment, isNew: Bool)
    func getStocks(isNew: Bool) -> [Stock]
}
