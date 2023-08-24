import UIKit

class BasketPageController: UIViewController, MainPageBaseCoordinated , Storyboardable{

    var data: [Stock]?
    var isNew: Bool = true
    var delegate: BasketPageDelegate?
    var coordinator: MainPageBaseCoordinator?
    private var segmentNamePopUp: SegmentNamePopUp!
    
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
}
extension BasketPageController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.basketCell, for: indexPath) as! BasketCell
        let stockItem = data![indexPath.row]
        cell.fillStock(stock: stockItem, add: addStock, remove: removeStock)
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
        
        self.segmentNamePopUp.buttonClick = createSegment
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


protocol BasketPageDelegate{
    func addSegment(segment: Segment, isNew: Bool)
}
