import UIKit

class StockTable: Component{
    
    var delegate: CellTapped!
    var data: [StockDetailed]?
    var field1: String = ""
    var field2: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func setup() {
        super.setup()
        setupTable()
    }
    

}
extension StockTable: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.stockCell, for: indexPath) as! StockItemCell
        let stockItem = data![indexPath.row]
        cell.fillStock(stock: stockItem, field1: field1, field2: field2)
        return cell
    }
    
    func setupTable(){
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.black
        tableView.register(UINib(nibName: Constants.Identifiers.stockCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.stockCell)
    }
}

extension StockTable: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (delegate != nil){
            delegate.cellTapped(indexOfCell: indexPath.row)
        }
    }
}

protocol CellTapped {
    func cellTapped(indexOfCell: Int)
}
