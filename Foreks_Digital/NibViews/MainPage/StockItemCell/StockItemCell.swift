//
//  StockItemCell.swift
//  Foreks_Digital
//
//  Created by FOREKS on 30.07.2023.
//

import UIKit

class StockItemCell: UITableViewCell {

   
    @IBOutlet weak var changeImage: UIImageView!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var fieldLabel1: UILabel!
    @IBOutlet weak var fieldLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dashedLine()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension StockItemCell{
    func fillStock(stock: StockDetailed, field1: String, field2: String){
        self.stockLabel.text = stock.id
        self.clockLabel.text = stock.stockDict["clo"] ?? "00.00"
        self.fieldLabel1.setFieldLabel(field: field1, stock: stock)
        self.fieldLabel2.setFieldLabel(field: field2, stock: stock)
        
        if stock.changePositive == nil{
            self.changeImage.image = Constants.images.minus
            self.changeImage.setImageColor(color: Constants.colors.lightwhite)
        }else{
            if stock.changePositive == true{
                self.changeImage.image = Constants.images.arrowup
                self.changeImage.setImageColor(color: Constants.colors.green)
            }else{
                self.changeImage.image = Constants.images.arrowdown
                self.changeImage.setImageColor(color: Constants.colors.red)
            }
        }
    }
}

extension UILabel{
    func setFieldLabel(field: String, stock: StockDetailed){
        var text = stock.stockDict[field] ?? "00.00"
        
        if (field == "pdd"){
            text = setTextPdd(txt: text)
            setTextColor(txt: text)
        }else if (field == "ddi"){
            setTextColor(txt: text)
        }
        else{
            self.textColor = UIColor.white
        }
        self.text = text

    }
    
    private func setTextPdd(txt: String) -> String{
        var text: String = txt
        if (text[0] == "-"){
            text = "-%" + text[1..<text.count]
        }else if (text != "00.00"){
            text = "%" + text
        }else{
            text = "%0.00"
        }
        return text
    }
    private func setTextColor(txt: String){
        if (txt[0] == "-"){
            self.textColor = Constants.colors.red
        }else if (txt != "%0.00"){
            self.textColor = Constants.colors.green
        }else{
            self.textColor = UIColor.white
        }
    }
}

