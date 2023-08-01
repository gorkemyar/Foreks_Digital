import Foundation
import UIKit

extension MainPageController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if page == nil || stocks.isEmpty{
            return 0
        }else{
            return stocks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.stockCell, for: indexPath) as! StockItemCell
        let stockItem = stocks[indexPath.row]
        
        cell.fillStock(stock: stockItem, field1: vm.field1, field2: vm.field2)
        return cell
    }
}

extension MainPageController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Identifiers.segueDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? DetailPageController {
            destination.stock = stocks[(stockTableView.indexPathForSelectedRow?.row) ?? 0]
        }
    }
    
}
