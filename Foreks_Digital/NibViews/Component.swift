import Foundation
import UIKit

@IBDesignable class Component: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    func setup(){
        loadNib().bind(to: self)
    }
}


extension UIView {
    func loadNib() -> UIView {
      let bundle = Bundle(for: type(of: self))
      let nibName = type(of: self).description().components(separatedBy: ".").last!
      let nib = UINib(nibName: nibName, bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
      return view
    }
    

    func bind(to view: UIView) {
        self.frame = view.bounds
        view.addSubview(self)
    }
}
