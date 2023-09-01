import UIKit


class StockTableController: UIViewController{
    
    var viewModel: MainPageViewModel!
    var delegate: StockTableControllerDelegate?
    var startSpin: (() -> Void)?
    private var isSpinning = false
    var tableView: UITableView = UITableView()

    
    override func loadView() {
        super.loadView()
        setupViewModel()
        setupTable()
        
        tableView.frame = view.frame
        
        view.addSubview(tableView)
    }
    
    
    func setupTable(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.black
        tableView.register(UINib(nibName: Constants.Identifiers.stockCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.stockCell)
    }
    
}

extension StockTableController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentStocks.value[viewModel.selectedSegment.value]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.stockCell, for: indexPath) as! StockItemCell
        let stockItem = viewModel.currentStocks.value[viewModel.selectedSegment.value]![indexPath.row]
        
        cell.fillStock(stock: stockItem, field1: viewModel.field1.value.key, field2: viewModel.field2.value.key)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        return cell
    }
}



extension StockTableController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (delegate != nil){
            delegate!.goToDetailPage(indexOfCell: indexPath.row)
        }

    }
}

protocol StockTableControllerDelegate {
    func goToDetailPage(indexOfCell: Int)
}


extension StockTableController{
    private func setupViewModel(){
        viewModel.currentStocks.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.selectedSegment.bind{ [weak self] res in
            self?.startSpin?()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
