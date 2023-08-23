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
        tableView.delegate = viewModel
        basketBar.delegate = viewModel
        basketBar.segmentio.selectedSegmentioIndex = viewModel.selectedSegment.value
        setButtonClick()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        viewModel.startLoadingDataTimer()
        createSpinnerView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        viewModel.stopTimer()
    }
 
    
    private func setupViewModel(){
        viewModel.mainPage.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.tableView.tableView.reloadData()
            }
        }
        viewModel.currentStocks.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.tableView.data = res[self?.viewModel.selectedSegment.value ?? 0]
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
        viewModel.segments.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.basketBar.segments = res ?? []
                self?.basketBar.segmentioSetup()
            }
        }
        viewModel.selectedSegment.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.tableView.data = self?.viewModel.currentStocks.value[res]
                self?.tableView.tableView.reloadData()
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
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}
