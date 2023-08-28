//
//  BasketCell.swift
//  Foreks_Digital
//
//  Created by FOREKS on 15.08.2023.
//

import UIKit

class BasketCell: UITableViewCell {

    
    var itemSelected: Bool = false;
    var add: ((Stock) -> Void)?
    var remove: ((Stock) -> Void)?
    var stock: Stock?
    
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var button: UIButton!
    

    @IBAction func click(_ sender: Any) {
        if itemSelected == false{
            setupRed()
            self.add?(stock!)
        }else{
            setupGreen()
            self.remove?(stock!)
        }
        itemSelected.toggle()
        
    }
    override func awakeFromNib() {
       super.awakeFromNib()
       dashedLine()
       setupGreen()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillStock(stock: Stock){
        stockName.text = stock.cod
        self.stock = stock
    }
    
    private func setupGreen(){
        let image: UIImage = Constants.images.plus
        self.button.setImage(image, for: .normal)
        self.button.backgroundColor = Constants.colors.green.withAlphaComponent(0.2)
        self.button.tintColor = Constants.colors.green
    }
    private func setupRed(){
        let image: UIImage = Constants.images.minus
        self.button.setImage(image, for: .normal)
        self.button.backgroundColor = Constants.colors.red.withAlphaComponent(0.2)
        self.button.tintColor = Constants.colors.red
    }
}
