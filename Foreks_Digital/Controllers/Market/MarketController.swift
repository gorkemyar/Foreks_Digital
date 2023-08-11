//
//  MarketController.swift
//  Foreks_Digital
//
//  Created by FOREKS on 7.08.2023.
//

import UIKit

class MarketController: UIViewController, MarketBaseCoordinated {
    
    var coordinator: MarketBaseCoordinator?
    
    init(coordinator: MarketBaseCoordinator?) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Exchange"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
        // Do any additional setup after loading the view.
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
