//
//  BasketCell.swift
//  Foreks_Digital
//
//  Created by FOREKS on 15.08.2023.
//

import UIKit

class BasketCell: UITableViewCell {

    
    var itemSelected: Observable<Bool> = Observable(false);
    var add: ((Stock) -> Void)?
    var remove: ((Stock) -> Void)?
    var stock: Stock?
    
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var button: UIButton!
    

    @IBAction func click(_ sender: Any) {
        if itemSelected.value == false{
            self.add?(stock!)
        }else{
            self.remove?(stock!)
        }
        itemSelected.value.toggle()
        
    }
    override func awakeFromNib() {
       super.awakeFromNib()
       dashedLine()
       setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillStock(stock: Stock, add: @escaping (Stock) -> Void, remove: @escaping (Stock) -> Void){
        stockName.text = stock.cod
        self.stock = stock
        self.add = add
        self.remove = remove
    }
    
    private func setup(){
        itemSelected.bind{ [weak self] res in
            DispatchQueue.main.async {
                if (res == true){
                    let image: UIImage = Constants.images.minus
                    self?.button.setImage(image, for: .normal)
                    self?.button.backgroundColor = Constants.colors.red.withAlphaComponent(0.2)
                    self?.button.tintColor = Constants.colors.red
                }else{
                    let image: UIImage = Constants.images.plus
                    self?.button.setImage(image, for: .normal)
                    self?.button.backgroundColor = Constants.colors.green.withAlphaComponent(0.2)
                    self?.button.tintColor = Constants.colors.green
                }
                
            }
        }
    }
    
    
}
