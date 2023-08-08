import Foundation
import UIKit

class PopUpTable: Component{
    
    var data: [SearchTypes] = []
    var click: ((String) -> Void)?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func setup() {
        super.setup()
        initTableView()
    }
    
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.black
        tableView.register(UINib(nibName: Constants.Identifiers.popupCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.popupCell)
        tableView.layer.cornerRadius = 10
    }
}


extension PopUpTable: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.popupCell, for: indexPath) as! PopUpCell
        let field = data[indexPath.row]
        cell.buttonOutlet.setTitle(field.name, for: .normal)
        return cell
    }
}


extension PopUpTable: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
    }

}
