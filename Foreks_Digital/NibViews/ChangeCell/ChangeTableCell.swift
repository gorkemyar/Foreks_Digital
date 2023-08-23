import UIKit

class ChangeTableCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func fillCell(image: UIImage, text: String){
        label.text = text
        button.setImage(image, for: .normal)
        button.tintColor = Constants.colors.yellow
        
    }
}
