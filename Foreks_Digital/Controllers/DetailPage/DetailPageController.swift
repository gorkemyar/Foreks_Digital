//
//  DetailPageController.swift
//  Foreks_Digital
//
//  Created by FOREKS on 31.07.2023.
//

import UIKit

class DetailPageController: UIViewController {

    var coordinator: MainPageBaseCoordinator?
    var stock: Observable<StockDetailed?> = Observable(nil)
    @IBOutlet weak var titleLabel: UILabel!
    
    static func initalizeVC(coordinator: MainPageBaseCoordinator, data: [String: Any]?) -> DetailPageController{
        let vc = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as! DetailPageController
        vc.coordinator = coordinator
        if (data != nil){
            vc.stock.value = data!["stock"] as? StockDetailed
        }
        return vc
    }

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
