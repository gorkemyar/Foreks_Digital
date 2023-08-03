import UIKit

class MainPageController: UIViewController {

    var viewModel: MainPageViewModel = MainPageViewModel()
    //private let popUp = PopUpOverlay()
    private var popUp: PopUp!
    
    @IBOutlet weak var stockTableView: UITableView!
    @IBOutlet var sembolBar: SembolBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillButtons()
        setButtonClick()
        
        navigationItem.hidesBackButton = true
        
        stockTableView.delegate = self
        stockTableView.dataSource = self
        stockTableView.backgroundColor = UIColor.black
        
        stockTableView.register(UINib(nibName: Constants.Identifiers.stockCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.stockCell)
        
        setupViewModel()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    private func setupViewModel(){
        viewModel.page.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.stockTableView.reloadData()
            }
        }
        viewModel.stocks.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.stockTableView.reloadData()
            }
        }
    }
}


// BarWith2Buttons extension functions
extension MainPageController{
    func fillButtons(){
        sembolBar.button1.setTitleWithPadding(field: viewModel.field1.value)
        sembolBar.button2.setTitleWithPadding(field: viewModel.field2.value)
    }
    
    func setButtonClick() {
        sembolBar.setClick(newClick: popupAppear)
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
        if viewModel.page.value == nil || viewModel.stocks.value.isEmpty{
            return 0
        }else{
            return viewModel.stocks.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.stockCell, for: indexPath) as! StockItemCell
        let stockItem = viewModel.stocks.value[indexPath.row]
        cell.fillStock(stock: stockItem, field1: viewModel.field1.value, field2: viewModel.field2.value)
        return cell
    }
}

extension MainPageController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Identifiers.segueDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? DetailPageController {
            destination.stock = viewModel.stocks.value[(stockTableView.indexPathForSelectedRow?.row) ?? 0]
        }
    }
    
}
