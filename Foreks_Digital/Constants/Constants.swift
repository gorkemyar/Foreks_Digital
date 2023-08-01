import Foundation
import UIKit

struct Constants{
    struct URLs {
        static let mainPage: String = "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com/default/ForeksMobileInterviewSettings"
        static let fields: String = "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com/default/ForeksMobileInterview"
        static let curreny: String = "https://api.genelpara.com/embed/borsa.json"
        static let fieldMarker: String = "?fields="
        static let stockNameMarker: String = "&stcs="
    }
    
    struct Identifiers {
        static let stockCell: String = "StockItemCell"
        static let segueDetail: String = "showDetail"
        static let popupCell: String = "PopUpCell"
    }
    
    struct edgeInsets {
        static let leftRight5: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    struct images {
        static let minus: UIImage = UIImage(systemName: "minus")!
        static let arrowup: UIImage = UIImage(systemName: "arrow.up")!
        static let arrowdown: UIImage = UIImage(systemName: "arrow.down")!
    }
    
    struct colors {
        static let lightwhite = UIColor.white.withAlphaComponent(0.5)
        static let green = UIColor.green.withAlphaComponent(0.8)
        static let red = UIColor.red.withAlphaComponent(0.8)
    }
}
