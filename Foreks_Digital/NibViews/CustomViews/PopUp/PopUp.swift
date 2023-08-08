import Foundation
import UIKit

@IBDesignable class PopUp: Component {
    
    @IBOutlet weak var backController: UIControl!
    
    var click: ((String) -> Void)!
    var tableView: UITableView = UITableView()
    var data: [SearchTypes] = []
    
    init(frame: CGRect, position: CGRect, data: [SearchTypes]){
        super.init(frame: frame)
        setup()
        self.data = data
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.appendView(position: position)
            self.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setup() {
        super.setup()
        backViewInit()
        initTableView()
    }
    
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.black
        tableView.register(UINib(nibName: Constants.Identifiers.popupCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.popupCell)
        tableView.layer.cornerRadius = 10
    }
    
    func backViewInit(){
        self.backController?.backgroundColor = .black.withAlphaComponent(0.5)
        
    }
    
    func appendView(position: CGRect){
        let height: CGFloat = CGFloat(200.0)
        let width: CGFloat = CGFloat(120.0)
        let x: CGFloat = position.minX - (width - position.width) / 2
        let y: CGFloat = position.minY + position.height + 10
        
        tableView.frame = CGRect(x: x, y: y, width: width, height: height)
        tableView.layer.cornerRadius = 10
        self.addSubview(tableView)
    }
}

extension PopUp: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.popupCell, for: indexPath) as! PopUpCell
        let field = data[indexPath.row]
        cell.label.text = field.name
        return cell
    }
}

extension PopUp: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        click(data[indexPath.row].key)
    }
}
