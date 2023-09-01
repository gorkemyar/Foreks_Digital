//
//  StockCore+CoreDataClass.swift
//  
//
//  Created by FOREKS on 29.08.2023.
//
//

import Foundation
import CoreData

@objc(StockCore)
public class StockCore: NSManagedObject {
    func toStock() -> Stock{
        return Stock(gro: gro!, cod: cod!, tke: tke!, def: def!)
    }
}
