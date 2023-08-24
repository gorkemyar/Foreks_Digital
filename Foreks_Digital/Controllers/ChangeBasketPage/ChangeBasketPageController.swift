import UIKit

class ChangeBasketPageController: UIViewController, MainPageBaseCoordinated, Storyboardable{
    
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    var data: Segment?
    var delegate: ChangeBasketPageControllerDelegate?
    var coordinator: MainPageBaseCoordinator?
    private var segmentNamePopUp: SegmentNamePopUp?
    private var swipeButton: UIButton?
    private var cell: UITableViewCell?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addSembols(_ sender: Any) {
        delegate?.addNewStockFromBasketPage()
    }
    
    @IBAction func changeName(_ sender: Any) {
        segmentNamePopUpAppear()
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.black
        tableView.register(UINib(nibName: Constants.Identifiers.changeCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.changeCell)
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(self.handleGestureTap(sender:)))
        view.addGestureRecognizer(gestureTap)
    }
    
    func setupUI(){
        changeButton.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
        addButton.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
        tableView.backgroundColor = UIColor.black
    }
}


extension ChangeBasketPageController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.search.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.changeCell, for: indexPath) as! ChangeTableCell
        let item = data!.search[indexPath.row]
        cell.fillCell(image: Constants.images.minuscircle, text: item.cod)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.swipeClick = { [self]() -> Void in
            animateRevealSwipeActionForRow(tableView: tableView, indexPath: indexPath)
        }
        return cell
    }
}

extension ChangeBasketPageController: UITableViewDelegate{}

extension ChangeBasketPageController{
    
    func animateRevealSwipeActionForRow(tableView: UITableView, indexPath: IndexPath) {
        if swipeButton != nil {
            animateHideSwipeActionForRow()
        }
        else{
            cell = tableView.cellForRow(at: indexPath)
            
            // Should be used in a block
            swipeButton = UIButton.init(frame: CGRect(x: cell!.bounds.size.width,
                                                                  y: 0,
                                                                  width: 80,
                                                                  height: cell!.bounds.size.height))

            swipeButton!.setTitle("Delete", for: .normal)
            swipeButton!.backgroundColor = UIColor.init(red: 255/255, green: 41/255, blue: 53/255, alpha: 1) // Red
            swipeButton!.setTitleColor(UIColor.white, for: .normal)
            swipeButton!.tag = indexPath.row
            swipeButton!.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
            cell!.addSubview(swipeButton!)

            UIView.animate(withDuration: 0.3, animations: {
                self.cell!.frame = CGRect(x: self.cell!.frame.origin.x - 80, y: self.cell!.frame.origin.y, width: self.cell!.bounds.size.width + 80, height: self.cell!.bounds.size.height)
            })
        }
    }
    
    func animateHideSwipeActionForRow(){
        if (swipeButton != nil){
            UIView.animate(withDuration: 0.3, animations: {
                self.cell!.frame = CGRect(x: self.cell!.frame.origin.x + 80, y: self.cell!.frame.origin.y, width: self.cell!.bounds.size.width - 80, height: self.cell!.bounds.size.height)

            }, completion: { (finished) in
                self.swipeButton?.removeFromSuperview()
                self.swipeButton = nil;
                self.cell = nil;
            })
        }
    }
    
    
    @objc
    func handleGestureTap(sender: UITapGestureRecognizer? = nil) {
      animateHideSwipeActionForRow()
      segmentOutsideClick()
    }
    
    @objc
    func deleteCell(sender: UIButton){
        self.data?.search.remove(at: sender.tag)
        delegate?.deleteStockFromSegment(delete: sender.tag)
        swipeButton = nil
        cell = nil
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension ChangeBasketPageController{
    func segmentNamePopUpAppear(){
        self.segmentNamePopUp = SegmentNamePopUp(frame: self.view.frame)
        self.segmentNamePopUp!.buttonClick = renameSegmentHelper
        self.view.addSubview(segmentNamePopUp!)
    }
    
    func renameSegmentHelper(name: String){
        delegate?.renameSegment(name: name)
        segmentOutsideClick()
    }
    
    
    func segmentOutsideClick(){
        self.segmentNamePopUp?.removeFromSuperview()
        self.segmentNamePopUp = nil
    }
    
    
}

protocol ChangeBasketPageControllerDelegate{
    func deleteStockFromSegment(delete index: Int)
    func addNewStockFromBasketPage()
    func renameSegment(name: String)
}
