import Foundation
import UIKit

@IBDesignable class SegmentNamePopUp: Component {
    
    
    @IBOutlet weak var backController: UIControl!
    var click: ((String) -> Void)!
    private var textField: UITextField!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.appendView(position: frame)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setup() {
        super.setup()
        backViewInit()
    }
    
    func backViewInit(){
        self.backController?.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    func appendView(position: CGRect){
        let height: CGFloat = CGFloat(120.0)
        let width: CGFloat = CGFloat(250.0)
        let x: CGFloat =  position.minX - (width - position.width) / 2
        let y: CGFloat =  position.minY - (height - position.height) / 2
        
        print(position)
        textField = UITextField(frame: CGRect(x: x, y: y, width: width, height: height))
        
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.white
        textField.placeholder = "New Basket Name"
        
        self.addSubview(textField)

    }
}


