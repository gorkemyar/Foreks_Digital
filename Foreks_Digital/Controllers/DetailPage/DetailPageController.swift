//
//  DetailPageController.swift
//  Foreks_Digital
//
//  Created by FOREKS on 31.07.2023.
//

import UIKit

class DetailPageController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var stock: Observable<StockDetailed?> = Observable(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    

    private func setup(){
        stock.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.titleLabel.text = self?.stock.value?.id ?? "Empty"
            }
        }
    }
}
