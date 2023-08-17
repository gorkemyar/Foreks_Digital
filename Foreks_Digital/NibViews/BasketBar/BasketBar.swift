import UIKit
import Segmentio

@IBDesignable class BasketBar: Component {

    var delegate: BasketBarDelegate?
    var segments: [Segment] = []
    
    @IBOutlet weak var segmentio: Segmentio!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func click(_ sender: Any) {
        delegate?.clickButton()
    }
    override func setup(){
        super.setup()
        buttonSetup()
    }
    
    
    func segmentioSetup(){
        SegmentioBuilder.buildSegmentioView(segmentioView: segmentio, segmentioStyle: SegmentioStyle.onlyLabel, segments: segmentioContent())
        segmentio.valueDidChange = { [weak self] item, segmentIndex in
            self?.delegate?.changeSegment(index: segmentIndex)
        }
    }
    
    private func buttonSetup(){
        let image: UIImage = Constants.images.plus
        addButton.setImage(image, for: .normal)
        addButton.tintColor = Constants.colors.yellow
    }
    
    private func segmentioContent() -> [SegmentioItem] {
        var content: [SegmentioItem] = []
        for segment in segments {
            content.append(SegmentioItem(title: segment.key, image: nil))
        }
        
        return content
    }
}

protocol BasketBarDelegate{
    func clickButton();
    func changeSegment(index: Int);
}

