import Foundation
import UIKit

@IBDesignable class TableView: Component, UITableViewDelegate{
    
    
    var data: [Any] = ["a", "a", "a", "a"]
    
    @IBOutlet var view: UIView!
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


extension TableView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.popupCell, for: indexPath) as! PopUpCell
        
        let field = data[indexPath.row]
        
        cell.buttonOutlet.setTitle(field as! String, for: .normal)
//        cell.hide = {() in self.clickCell(field: field)}
        return cell
    }
    
    private func clickCell(field: SearchTypes){
//        MainPageViewModel.shared.changeField(field: field.key, whichField: whichField)
//        if fillButtons != nil{
//            fillButtons!()
//        }
//        hide()
    }
    

}
