import Foundation
import UIKit

@IBDesignable class SegmentNamePopUp: Component {
    
    
    @IBOutlet weak var backController: UIControl!
    var buttonClick: ((String) -> Void)!

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
        
        
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let view: UIView = UIView(frame: frame)
        view.backgroundColor = Constants.colors.bg
        let viewFrame = view.frame
        
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: viewFrame.width, height: viewFrame.height/2))
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(10)
        textField.backgroundColor = UIColor.white
        textField.placeholder = "New Basket Name"
 
        
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: viewFrame.height / 2, width: viewFrame.width, height: viewFrame.height/2))
        button.backgroundColor = Constants.colors.bg
        button.setTitle("Create a Segment", for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(createSegment) , for: .touchUpInside)
        
        view.addSubview(textField)
        view.addSubview(button)
        
        view.layer.cornerRadius = 10
        self.addSubview(view)

    }
    @objc func createSegment(){
        if textField.text?.isEmpty ?? true {
            textField.attributedPlaceholder = NSAttributedString(string: "*Please enter a basket name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.7)])
        }else{
            buttonClick(textField.text!)
        }
    }
    
}


