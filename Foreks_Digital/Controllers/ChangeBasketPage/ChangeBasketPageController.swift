import UIKit

class ChangeBasketPageController: UIViewController, MainPageBaseCoordinated, Storyboardable{
    
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    var data: Segment?
    var delegate: ChangeBasketPageControllerDelegate?
    var coordinator: MainPageBaseCoordinator?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addSembols(_ sender: Any) {
    }
    
    @IBAction func changeName(_ sender: Any) {
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    func setupUI(){
        changeButton.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
        addButton.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
        tableView.backgroundColor = UIColor.black
    }
}

protocol ChangeBasketPageControllerDelegate{
    
}

