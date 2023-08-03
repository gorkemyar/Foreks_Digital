import UIKit

@IBDesignable class BarWith2Buttons: Component {
    
    private var click: ((Int, CGRect) -> Void)?
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    
    @IBAction func Click(_ sender: UIButton) {
        if click != nil {
            click!(sender.tag, sender.frame)
        }
    }

    func setClick(newClick:@escaping (Int, CGRect) -> Void){
        click = newClick
    }
}


/** Loads instance from nib with the same name. */
 
