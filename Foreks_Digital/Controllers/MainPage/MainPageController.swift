import UIKit

class MainPageController: UIViewController, MainPageBaseCoordinated {
    
    var coordinator: MainPageBaseCoordinator?

    var viewModel: MainPageViewModel = MainPageViewModel()
    private var popUp: PopUp!
    
    @IBOutlet weak var tableView: StockTable!
    @IBOutlet var sembolBar: SembolBar!
    
    static func initializeVC(coordinator: MainPageBaseCoordinator) -> MainPageController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainPageController
        vc.coordinator = coordinator
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        tableView.delegate = self
        setButtonClick()
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
                self?.sembolBar.button1.setTitleWithPadding(field: res.name)
                self?.tableView.field1 = res
            }
        }
        viewModel.field2.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.sembolBar.button2.setTitleWithPadding(field: res.name)
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
    func popupAppear(whichField: Int, pos: CGRect) {
        self.popUp = PopUp(frame: self.view.frame, position: pos, data: viewModel.page.value?.mainPageSearches ?? [])
        self.popUp.click = {(idx: Int) -> Void in
            let field: SearchTypes = self.viewModel.page.value!.mainPageSearches[idx]
            self.viewModel.changeField(field: field, whichField: whichField);
            self.outsideClick();
        }
        
        self.popUp.backController.addTarget(self, action: #selector(outsideClick), for: .touchUpInside)
        self.view.addSubview(popUp)
    }
    
    @objc func outsideClick(){
        self.popUp.removeFromSuperview()
    }
}

extension MainPageController: CellTapped{
    func cellTapped(indexOfCell: Int) {
        coordinator?.moveTo(flow: .main(.detailScreen), userData: ["stock": self.tableView.data?[indexOfCell] as Any])
    }
}

