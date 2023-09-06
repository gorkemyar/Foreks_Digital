//
//  Finance.swift
//  Foreks_Digital
//
//  Created by FOREKS on 6.09.2023.
//

import UIKit

class Information4: Component {

    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var titleOne: UILabel!
    @IBOutlet weak var titleTwo: UILabel!
    @IBOutlet weak var titleThree: UILabel!
    @IBOutlet weak var titleFour: UILabel!
    
    @IBOutlet weak var valueOne: UILabel!
    @IBOutlet weak var valueTwo: UILabel!
    @IBOutlet weak var valueThree: UILabel!
    @IBOutlet weak var valueFour: UILabel!
    
    
    func setInformation4(main: String, title1: String, title2: String, title3: String, title4: String, value1: String, value2: String, value3: String, value4: String){
        
        mainTitle.text = main
        titleOne.text = title1
        titleTwo.text = title2
        titleThree.text = title3
        titleFour.text = title4
        
        valueOne.text = value1
        valueTwo.text = value2
        valueThree.text = value3
        valueFour.text = value4
  
    }
}
