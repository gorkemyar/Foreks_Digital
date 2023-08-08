import Foundation
import UIKit

@IBDesignable class PopUp: Component {
    
    @IBOutlet weak var backController: UIControl!
    var getData: (() -> [SearchTypes])!
    var click: ((String) -> Void)!
    
    init(frame: CGRect, position: CGRect){
        super.init(frame: frame)
        setup()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.appendView(position: position)
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
        let customView = PopUpTable()
        customView.data = getData()
        customView.click = click
        
        
        let height: CGFloat = CGFloat(200.0)
        let width: CGFloat = CGFloat(120.0)
        let x: CGFloat = position.minX - (width - position.width) / 2
        let y: CGFloat = position.minY + position.height + 10
        
        
        customView.frame = CGRect(x: x, y: y, width: width, height: height)
        customView.backgroundColor = UIColor.black
        customView.layer.cornerRadius = 10
        self.addSubview(customView)
    }
}
