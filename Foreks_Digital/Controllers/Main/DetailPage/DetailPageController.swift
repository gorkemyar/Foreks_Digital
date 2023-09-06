//
//  DetailPageController.swift
//  Foreks_Digital
//
//  Created by FOREKS on 31.07.2023.
//

import UIKit
import DGCharts

class DetailPageController: UIViewController, MainPageBaseCoordinated, Storyboardable {

    @IBOutlet weak var infoBar: InfoBar!
    var coordinator: MainPageBaseCoordinator?
    var viewModel: DetailPageViewModel!

    
    @IBOutlet weak var finance: Information3!
    @IBOutlet weak var sector: Information4!
    @IBOutlet weak var profile: Information4!
    
    @IBOutlet weak var lineChart: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.startLoadingDataTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopTimer()
    }

    private func setup(){
        setBindings()
        setNavigationBar()
        setLineChartData()
        line()
        setInformation()
    }
    private func setBindings(){
        viewModel.stock.bind{ [weak self] res in
            DispatchQueue.main.async {
                self?.navigationController?.navigationBar.topItem?.title = res.id
                self?.infoBar.fillBar(change: res.changePositive, clock: res.stockDict["clo"] ?? "00.00", price: res.stockDict["las"] ?? "00.00")
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
        lineChart.data = data
    }
}

extension DetailPageController{
    func line(){
        let layer = CAShapeLayer()
        layer.strokeColor = Constants.colors.green.cgColor
        layer.lineDashPattern = [5,5]; // Here you set line length
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 10, y: infoBar.frame.height),
                                CGPoint(x: infoBar.frame.width-20, y: infoBar.frame.height)])
        
        layer.path = path
        
        self.infoBar.layer.addSublayer(layer)
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
extension DetailPageController{
    private func setInformation(){
        finance.layer.borderWidth = 1
        finance.layer.borderColor = Constants.colors.gray.cgColor
        finance.layer.cornerRadius = 5
        sector.layer.borderWidth = 1
        sector.layer.borderColor = Constants.colors.gray.cgColor
        sector.layer.cornerRadius = 5
        profile.layer.borderWidth = 1
        profile.layer.borderColor = Constants.colors.gray.cgColor
        profile.layer.cornerRadius = 5
        
        finance.setInformation3(main: "Financial Summary", title1: "Registered Capital", title2: "Market Value", title3: "Net Income", value1: "4.200.000.000", value2: "215.880.000.000", value3: "71.618.204")
        sector.setInformation4(main: "Sector Information", title1: "Sector", title2: "Company Count", title3: "F/K", title4: "PD/DD", value1: "BANKALAR", value2: "15", value3: "141.93", value4: "47.65")
        profile.setInformation4(main: "Company Profile", title1: "Company Title", title2: "Establish Date", title3: "Address", title4: "Activity", value1: "Garanti", value2: "05/08/2008", value3: "Levent, Istanbul", value4: "Ticari Bankacılık")
    }
}
