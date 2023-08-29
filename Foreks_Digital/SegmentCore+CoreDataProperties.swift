//
//  SegmentCore+CoreDataProperties.swift
//  
//
//  Created by FOREKS on 29.08.2023.
//
//

import Foundation
import CoreData


extension SegmentCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SegmentCore> {
        return NSFetchRequest<SegmentCore>(entityName: "SegmentCore")
    }

    @NSManaged public var key: String?
    @NSManaged public var segmentStocks: NSSet?

}

// MARK: Generated accessors for segmentStocks
extension SegmentCore {

    @objc(addSegmentStocksObject:)
    @NSManaged public func addToSegmentStocks(_ value: StockCore)

    @objc(removeSegmentStocksObject:)
    @NSManaged public func removeFromSegmentStocks(_ value: StockCore)

    @objc(addSegmentStocks:)
    @NSManaged public func addToSegmentStocks(_ values: NSSet)

    @objc(removeSegmentStocks:)
    @NSManaged public func removeFromSegmentStocks(_ values: NSSet)

}
