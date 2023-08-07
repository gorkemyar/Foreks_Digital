import Foundation
import UIKit

@IBDesignable class PopUp: Component {
    
    @IBOutlet weak var backController: UIControl!

    override func setup() {
        super.setup()
        backViewInit()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
           self.appendView()
        }
    }
    
    func backViewInit(){
        self.backController?.backgroundColor = .black.withAlphaComponent(0.5)
        
    }
    
    func appendView(){
        let customView = PopUpTable()
        self.addSubview(customView)
        customView.frame = CGRect(x: 100, y: 100, width: 150, height: 250)
        customView.backgroundColor = UIColor.black
        customView.layer.cornerRadius = 10
    }
}
