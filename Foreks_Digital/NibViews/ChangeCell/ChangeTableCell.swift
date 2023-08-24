import UIKit

class ChangeTableCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func swipeDelete(_ sender: Any) {
        swipeClick?()
    }
    var swipeClick: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dashedLine()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func fillCell(image: UIImage, text: String){
        label.text = text
        button.setImage(image, for: .normal)
        button.tintColor = Constants.colors.red
        
    }
}
