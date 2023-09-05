//
//  DetailPageController.swift
//  Foreks_Digital
//
//  Created by FOREKS on 31.07.2023.
//

import UIKit
import DGCharts

class DetailPageController: UIViewController, MainPageBaseCoordinated, Storyboardable {

    var coordinator: MainPageBaseCoordinator?
    var stock: Observable<StockDetailed?> = Observable(nil)

    @IBOutlet weak var lineChart: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        setNavigationBar()
        setLineChartData()
    }
    

    private func setup(){
        stock.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.navigationController?.navigationBar.topItem?.title = res?.id ?? "Empty"
            }
        }
    }
}

extension DetailPageController{
    private func setLineChartData(){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<50{
            let value = ChartDataEntry(x: Double(i), y: Double.random(in: 500..<1000))
            lineChartEntry.append(value)
        }
        
        let line = LineChartDataSet(entries: lineChartEntry, label: "Stock Prices")
        line.colors = [Constants.colors.green]
        line.drawCirclesEnabled = false
        line.drawValuesEnabled = false
        line.lineWidth = 2
        line.fillAlpha = 0.3
        line.drawFilledEnabled = true
        line.fillColor = Constants.colors.green
        
        let data = LineChartData(dataSet: line)
        
        //lineChart.tintColor = Constants.colors.lightwhite
        //lineChart.noDataTextColor = Constants.colors.lightwhite
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.leftAxis.axisMinimum = 500
        lineChart.leftAxis.axisMaximum = 1000
        lineChart.leftAxis.labelTextColor = Constants.colors.lightwhite
        lineChart.rightAxis.enabled = false
        lineChart.drawBordersEnabled = false
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.labelTextColor = Constants.colors.lightwhite
        lineChart.legend.enabled = false
        
        
        //lineChart.bottom.drawGridBackgroundEnabled = false
        lineChart.data = data
        
    
        
    }
}





extension DetailPageController{
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
