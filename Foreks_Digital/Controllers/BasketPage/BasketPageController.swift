import UIKit

class BasketPageController: UIViewController, MainPageBaseCoordinated , Storyboardable{

    var data: [Stock] = []
    var coordinator: MainPageBaseCoordinator?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.black
        tableView.register(UINib(nibName: Constants.Identifiers.basketCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.basketCell)
    }
}
extension BasketPageController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.basketCell, for: indexPath) as! BasketCell
        let stockItem = data[indexPath.row]
        cell.fillStock(stock: stockItem)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        return cell
    }
}
extension BasketPageController: UITableViewDelegate{
    
}


