//
//  DetailPageController.swift
//  Foreks_Digital
//
//  Created by FOREKS on 31.07.2023.
//

import UIKit

class DetailPageController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var stock: StockDetailed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = stock?.id ?? "Empty"
    }
    

}
