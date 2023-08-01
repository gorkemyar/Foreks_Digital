import UIKit

class PopUpOverlay: UIViewController, UITableViewDelegate {
    
    
    var whichField: Int = 0
    var fillButtons: (()->Void)?
    
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var tableView: UITableView!
    
    init(){
        super.init(nibName: "PopUpOverlay", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
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


// Extension for TableView
extension PopUpOverlay: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainPageViewModel.shared.page?.mainPageSearches.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.popupCell, for: indexPath) as! PopUpCell
        
        let field = MainPageViewModel.shared.page!.mainPageSearches[indexPath.row]
        cell.buttonOutlet.setTitle(field.name, for: .normal)
        cell.hide = {() in self.clickCell(field: field)}
        return cell
    }
    
    private func clickCell(field: SearchTypes){
        
        
        
        MainPageViewModel.shared.changeField(field: field.key, whichField: whichField)
        if fillButtons != nil{
            fillButtons!()
        }
        hide()
    }
    
}

// Popup open close extensions
extension PopUpOverlay {
    func configView(){
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.3)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController, whichField: Int, fillButtons: @escaping ()->Void){
        sender.present(self, animated: false){
            self.show()
        }
        self.whichField = whichField
        self.fillButtons = fillButtons
        self.tableView.reloadData()
    }
    
    private func show(){
        UIView.animate(withDuration: 0.2, delay: 0){
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide(){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut){
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}
