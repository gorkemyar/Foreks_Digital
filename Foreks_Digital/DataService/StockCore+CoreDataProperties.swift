//
//  StockCore+CoreDataProperties.swift
//  
//
//  Created by FOREKS on 29.08.2023.
//
//

import Foundation
import CoreData


extension StockCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StockCore> {
        return NSFetchRequest<StockCore>(entityName: "StockCore")
    }

    @NSManaged public var gro: String?
    @NSManaged public var cod: String?
    @NSManaged public var tke: String?
    @NSManaged public var def: String?
    @NSManaged public var stockToSegment: SegmentCore?
}
