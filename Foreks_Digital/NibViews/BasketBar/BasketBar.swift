import UIKit
import Segmentio

@IBDesignable class BasketBar: Component {


    @IBOutlet weak var segmentio: Segmentio!
    
    override func setup(){
        super.setup()
        segmentioSetup()
    }
    
    
    private func segmentioSetup(){
        segmentio.backgroundColor = UIColor.white
        let items: [SegmentioItem] = segmentioCreateItems()
        segmentio.setup(content: items, style: SegmentioStyle.imageBeforeLabel, options: segmentioOptions())
        segmentio.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
        }
    }
    
    private func segmentioCreateItems() -> [SegmentioItem]{
        
        var items = [SegmentioItem]()
        var item1 = SegmentioItem(
            title: "Person",
            image: nil
        )
        var item2 = SegmentioItem(
            title: "Person",
            image: nil
        )
        item1.badgeColor = UIColor.red
        item2.badgeColor = UIColor.blue
        items.append(item1)
        items.append(item2)
        return items
    }
    
    private func segmentioOptions() -> SegmentioOptions{
        return SegmentioOptions(
            backgroundColor: Constants.colors.bg,
                    segmentPosition: SegmentioPosition.dynamic,
                    scrollEnabled: true,
                    indicatorOptions: nil,
                    horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(color: Constants.colors.lightwhite)
        )
    }
}
