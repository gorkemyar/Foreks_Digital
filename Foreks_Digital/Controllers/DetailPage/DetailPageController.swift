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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
