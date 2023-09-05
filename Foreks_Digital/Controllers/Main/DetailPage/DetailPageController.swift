//
//  DetailPageController.swift
//  Foreks_Digital
//
//  Created by FOREKS on 31.07.2023.
//

import UIKit

class DetailPageController: UIViewController, MainPageBaseCoordinated, Storyboardable {

    var coordinator: MainPageBaseCoordinator?
    var stock: Observable<StockDetailed?> = Observable(nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        setNavigationBar()
    }
    

    private func setup(){
        stock.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.navigationController?.navigationBar.topItem?.title = res?.id ?? "Empty"
            }
        }
    }
    
    private func setNavigationBar(){
        self.navigationController?.navigationBar.tintColor = Constants.colors.yellow
        navigationController?.navigationBar.topItem?.title = ""
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Constants.colors.bg
            self.navigationController?.navigationBar.isTranslucent = true
            appearance.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: Constants.colors.lightwhite]
            appearance.shadowColor = .clear    //removing navigationbar 1 px bottom border.
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
