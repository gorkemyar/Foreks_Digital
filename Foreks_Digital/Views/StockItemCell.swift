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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension StockItemCell{
    
    private func dashedLine(){
          let color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
          let shapeLayer:CAShapeLayer = CAShapeLayer()
          let frameSize = self.frame.size
          let fsize = UIScreen.main.bounds
          let shapeRect = CGRect(x: 0, y: 0, width: fsize.width/1.1, height: 0)
          
          shapeLayer.bounds = shapeRect
          shapeLayer.position = CGPoint(x: fsize.width/2, y: frameSize.height)
          shapeLayer.fillColor = UIColor.clear.cgColor
          shapeLayer.strokeColor = color
          shapeLayer.lineWidth = 1
          shapeLayer.lineJoin = CAShapeLayerLineJoin.round
          shapeLayer.lineDashPattern = [2,4]
          shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: shapeRect.height, width: shapeRect.width, height: 0), cornerRadius: 0).cgPath
          
          self.layer.addSublayer(shapeLayer)
    }
    
    
    func fillStock(stock: StockDetailed, field1: String, field2: String){
        self.stockLabel.text = stock.id
        self.clockLabel.text = stock.stockDict["clo"] ?? "00.00"
        self.fieldLabel1.text = stock.stockDict[field1] ?? "00.00"
        self.fieldLabel2.text = stock.stockDict[field2] ?? "00.00"
        if stock.changePositive == nil{
            self.changeImage.image = UIImage(systemName: "minus")
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
            self.changeImage.setImageColor(color: color)
            
        }else{
            if stock.changePositive == true{
                self.changeImage.image = UIImage(systemName: "arrow.up")
                self.changeImage.setImageColor(color: UIColor.green.withAlphaComponent(0.8))
            }else{
                self.changeImage.image = UIImage(systemName: "arrow.down")
                self.changeImage.setImageColor(color: UIColor.red.withAlphaComponent(0.8))
            }
        }
        dashedLine()
    }
}


