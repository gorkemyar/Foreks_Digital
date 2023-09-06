//
//  InfoBar.swift
//  Foreks_Digital
//
//  Created by FOREKS on 6.09.2023.
//

import UIKit

class InfoBar: Component {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    func fillBar(change: Bool?, clock: String, price: String){
        self.nameLabel.text = price
        self.timeLabel.text = clock
    
        if change == nil{
            self.image.image = Constants.images.minus
            self.image.setImageColor(color: Constants.colors.lightwhite)
        }else{
            if change == true{
                self.image.image = Constants.images.arrowup
                self.image.setImageColor(color: Constants.colors.green)
            }else{
                self.image.image = Constants.images.arrowdown
                self.image.setImageColor(color: Constants.colors.red)
            }
        }
    }

}
