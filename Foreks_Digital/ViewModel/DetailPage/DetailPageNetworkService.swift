//
//  DetailPageNetworkService.swift
//  Foreks_Digital
//
//  Created by FOREKS on 6.09.2023.
//

import Foundation

final class DetailPageNetworkService{
 
    func getStockDetailed(stockName: String, fields: [String]  ,completion: @escaping (Result<StockDetailedHelper, Error>) -> Void){
        let url = URLGeneration.GetFieldsURL(fields: fields, stockName: stockName)
        NetworkManager.requestSession(resource: Resource<StockDetailedHelper>(url: url)) {
            result in completion(result)
        }
    }
    
    
    func isChangePositive(stockOld: StockDetailed, newStock: StockDetailed, fields:[String]) -> Bool?{
        
        let f1: String = fields[0];
        var changePositive: Bool? = stockOld.changePositive
        
        // Check existence of the fields and decide whether the current is bigger or later
        if stockOld.stockDict[f1] != nil && newStock.stockDict[f1] != nil {
            if stockOld.stockDict[f1]! < newStock.stockDict[f1]!{
                changePositive = true
            }
            else if stockOld.stockDict[f1]! > newStock.stockDict[f1]!{
                changePositive = false
            }
        }
        
        return changePositive
    }
}
