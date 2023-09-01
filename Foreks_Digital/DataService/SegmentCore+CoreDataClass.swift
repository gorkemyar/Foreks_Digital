//
//  SegmentCore+CoreDataClass.swift
//  
//
//  Created by FOREKS on 29.08.2023.
//
//

import Foundation
import CoreData

@objc(SegmentCore)
public class SegmentCore: NSManagedObject {
    func toSegment() -> Segment{
        var stocks: [Stock] = (self.segmentStocks as! Set<StockCore>).map{$0.toStock()}
        return Segment(key: key!, search: stocks)
    }
}
