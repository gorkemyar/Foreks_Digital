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
