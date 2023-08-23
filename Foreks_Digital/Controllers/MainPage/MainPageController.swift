import UIKit

class MainPageController: UIViewController, MainPageBaseCoordinated, Storyboardable {
    
    var coordinator: MainPageBaseCoordinator?
    var viewModel: MainPageViewModel!
    var stockTableView: StockTableController?
    var spinnerView: SpinnerViewController?
    private var popUp: PopUp!

    @IBOutlet weak var mainView: UIView!
    @IBOutlet var sembolBar: SembolBar!
    @IBOutlet weak var basketBar: BasketBar!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        basketBar.delegate = viewModel
        basketBar.segmentio.selectedSegmentioIndex = viewModel.selectedSegment.value
        setButtonClick()
        setupViewModel()
        
        createStockTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        viewModel.startLoadingDataTimer()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        viewModel.stopTimer()
    }
 
    
    private func setupViewModel(){
        viewModel.field1.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.sembolBar.button1.setTitleWithPadding(field: res.name)
            }
        }
        viewModel.field2.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.sembolBar.button2.setTitleWithPadding(field: res.name)
            }
        }
        viewModel.segments.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.basketBar.segments = res ?? []
                self?.basketBar.segmentioSetup()
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


extension MainPageController{
    func startSpinnerView() {
        spinnerView = SpinnerViewController()

        addChild(spinnerView!)
        spinnerView!.view.frame = view.frame
        view.addSubview(spinnerView!.view)
        spinnerView!.didMove(toParent: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.spinnerView?.willMove(toParent: nil)
            self.spinnerView?.view.removeFromSuperview()
            self.spinnerView?.removeFromParent()
        }
    }
    func stopSpinnerView(){
        
    }
    func createStockTableView(){
        stockTableView = StockTableController()
        stockTableView!.viewModel = viewModel
        stockTableView!.delegate = viewModel
        stockTableView!.startSpin = startSpinnerView
        
        addChild(stockTableView!)
        stockTableView!.view.frame = view.frame
        mainView.addSubview(stockTableView!.view)
        stockTableView!.didMove(toParent: self)
    }

}
