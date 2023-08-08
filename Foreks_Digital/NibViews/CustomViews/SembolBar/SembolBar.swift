import UIKit

@IBDesignable class SembolBar: Component {
    
    private var click: ((Int, CGRect) -> Void)?
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    
    @IBAction func Click(_ sender: UIButton) {
        if click != nil {
            if let window = UIApplication.shared.keyWindow {
                let pos: CGPoint = sender.convert(sender.bounds.origin, to: window)
                let size: CGSize = sender.bounds.size
                let frame: CGRect = CGRect(origin: pos, size: size)
                click!(sender.tag, frame)
            }
        }
    }

    func setClick(newClick:@escaping (Int, CGRect) -> Void){
        click = newClick
    }
}


/** Loads instance from nib with the same name. */
 
