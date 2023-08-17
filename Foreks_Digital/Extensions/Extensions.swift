import Foundation
import UIKit

extension CALayer {
    @objc var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
    self.backgroundColor = color.withAlphaComponent(0.15)
  }
}

extension UIButton{
    func setTitleWithPadding(field: String){
        self.setTitle(field, for: .normal)
        
        if #available(iOS 15.0, *){
            //var configuration = UIButton.Configuration.borderless()
            //configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing:5)
            
            //self.configuration?.updated(for: configuration.)
            self.contentEdgeInsets = Constants.edgeInsets.leftRight5
        }else{
            self.contentEdgeInsets = Constants.edgeInsets.leftRight5
        }
    }
}


extension String {
    subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }

    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }
}

extension UITableViewCell{
    func dashedLine(){
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

}
