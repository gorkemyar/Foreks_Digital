import UIKit

class MainPageController: UIViewController, MainPageBaseCoordinated, Storyboardable {
    
    var coordinator: MainPageBaseCoordinator?
    var viewModel: MainPageViewModel!
    private var popUp: PopUp!
    
    @IBOutlet weak var tableView: StockTable!
    @IBOutlet var sembolBar: SembolBar!
    @IBOutlet weak var basketBar: BasketBar!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.delegate = self
        basketBar.delegate = self
        basketBar.segments = self.viewModel.segments.value ?? []
        basketBar.segmentio.selectedSegmentioIndex = viewModel.selectedSegment
        setButtonClick()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    
    private func setupViewModel(){
        viewModel.mainPage.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.tableView.tableView.reloadData()
            }
        }
        viewModel.segments.bind{ [weak self] res in
            DispatchQueue.main.async {
                if res != nil {
                    self?.basketBar.segmentioSetup()
                    self?.tableView.data = res![self?.viewModel.selectedSegment ?? 0].value
                    self?.basketBar.segments = res!
                    self?.tableView.tableView.reloadData()
                }
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
        self.popUp = PopUp(frame: self.view.frame, position: pos, data: viewModel.mainPage.value?.mainPageSearches ?? [])
        self.popUp.click = {(idx: Int) -> Void in
            let field: SearchTypes = self.viewModel.mainPage.value!.mainPageSearches[idx]
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

extension MainPageController: BasketBarDelegate{
    func clickButton() {
        coordinator?.moveTo(flow: .main(.basketScreen), userData: nil)
    }
    func changeSegment(index: Int){
        viewModel.selectedSegment = index
    }
}



