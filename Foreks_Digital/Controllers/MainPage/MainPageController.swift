import UIKit

class MainPageController: UIViewController {

    var viewModel: MainPageViewModel = MainPageViewModel()
    private var popUp: PopUp!
    
    @IBOutlet weak var tableView: StockTable!
    @IBOutlet var sembolBar: SembolBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        tableView.delegate = self
        setButtonClick()
        //setupTable()
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
                self?.tableView.tableView.reloadData()
            }
        }
        viewModel.stocks.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.tableView.data = res
                self?.tableView.tableView.reloadData()
            }
        }
        viewModel.field1.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.sembolBar.button1.setTitleWithPadding(field: res)
                self?.tableView.field1 = res
            }
        }
        viewModel.field2.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.sembolBar.button2.setTitleWithPadding(field: res)
                self?.tableView.field2 = res
            }
        }
    }
}


// SembolBar and Popup setup
extension MainPageController{
    func setButtonClick() {
        sembolBar.setClick(newClick: popupAppear)
    }
    
    func popupAppear(whichField: Int, frame: CGRect) {
        self.popUp = PopUp(frame: self.view.frame)
        self.popUp.backController.addTarget(self, action: #selector(outsideClick), for: .touchUpInside)
        self.view.addSubview(popUp)
    }
    
    @objc func outsideClick(){
        self.popUp.removeFromSuperview()
    }
}

extension MainPageController: CellTapped{
    func cellTapped(indexOfCell: Int) {
        let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
        let detail = storyBoard.instantiateInitialViewController() as! DetailPageController
        detail.stock = tableView.data?[indexOfCell]
        navigationController?.pushViewController(detail, animated: false)
    }
}
