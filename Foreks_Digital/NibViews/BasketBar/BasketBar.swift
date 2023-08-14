import UIKit
import Segmentio

@IBDesignable class BasketBar: Component {

    var delegate: AddButtonClicked?
    
    @IBOutlet weak var segmentio: Segmentio!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func click(_ sender: Any) {
        delegate?.clickButton()
    }
    override func setup(){
        super.setup()
        segmentioSetup()
        buttonSetup()
    }
    
    
    private func segmentioSetup(){
        SegmentioBuilder.buildSegmentioView(segmentioView: segmentio, segmentioStyle: SegmentioStyle.onlyLabel)
        segmentio.valueDidChange = { [weak self] item, segmentIndex in
            print(segmentIndex)
        }
    }
    
    private func buttonSetup(){
        let image: UIImage = Constants.images.plus
        addButton.setImage(image, for: .normal)
        addButton.tintColor = Constants.colors.yellow
    }
}

protocol AddButtonClicked{
    func clickButton();
}
