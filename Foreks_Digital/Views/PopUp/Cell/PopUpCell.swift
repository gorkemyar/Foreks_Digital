//
//  PopUpCell.swift
//  Foreks_Digital
//
//  Created by FOREKS on 1.08.2023.
//

import UIKit

class PopUpCell: UITableViewCell {

    var hide: (() -> Void)?
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBAction func clickPopUpButton(_ sender: Any) {
        if hide != nil {
            hide!()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
