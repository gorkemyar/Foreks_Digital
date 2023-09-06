import UIKit
import Segmentio

@IBDesignable class BasketBar: Component {

    var delegate: BasketBarDelegate?
    var segments: [Segment] = []
    
    @IBOutlet weak var segmentio: Segmentio!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var changeButton: UIButton!
    
    
    @IBAction func changeClick(_ sender: Any) {
        delegate?.clickChangeButton()
    }
    @IBAction func addClick(_ sender: Any) {
        delegate?.clickAddButton()
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
        let addImage: UIImage = Constants.images.plus
        addButton.setImage(addImage, for: .normal)
        addButton.tintColor = Constants.colors.yellow
        let settingImage: UIImage = Constants.images.settings
        changeButton.setImage(settingImage, for: .normal)
        changeButton.tintColor = Constants.colors.yellow
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
    func clickAddButton();
    func clickChangeButton();
    
    func changeSegment(index: Int);
    
}

