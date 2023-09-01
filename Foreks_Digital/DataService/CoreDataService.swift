import Foundation
import CoreData

class CoreDataService: DataService{
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    init(modelName: String){
        persistentContainer = NSPersistentContainer(name: modelName)
        load()
    }
    
    func load(completion: (()->Void)? = nil){
        persistentContainer.loadPersistentStores{
            (description, error) in
            guard error == nil else{
                fatalError(error!.localizedDescription)
            }
            
            completion?()
            
            
        }
    }
    
    func save(){
        if viewContext.hasChanges{
            do {
                try viewContext.save()
            }catch{
                print("An error occured while saving context \(error.localizedDescription).")
            }
            
        }
    }
}


extension CoreDataService{
    func getSegments() -> [Segment]{
        do {
            let fetchRequest: NSFetchRequest<SegmentCore> = SegmentCore.fetchRequest()
            let segments: [Segment] = try viewContext.fetch(fetchRequest).map{$0.toSegment()}
            return segments
        }catch{
            print("An error occured while fetching segments \(error.localizedDescription).")
            return []
        }
    }
    
    func addSegment(segment: Segment){
        let newSegment = SegmentCore(context: viewContext)
        newSegment.key = segment.key
        for stock in segment.search{
            let newStock = StockCore(context: viewContext)
            newStock.cod = stock.cod
            newStock.def = stock.def
            newStock.tke = stock.tke
            newStock.gro = stock.gro
            newStock.stockToSegment = newSegment
            newSegment.addToSegmentStocks(newStock)
        }
        save()
    }
    
    func updateSegmentName(oldName: String, newName: String){
        do {
            let fetchRequest: NSFetchRequest<SegmentCore> = SegmentCore.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "key LIKE %@", oldName)
            let segment: SegmentCore? = try viewContext.fetch(fetchRequest).first
            segment?.key = newName
            save()
        }catch{
            print("An error occured while changing segment name \(error.localizedDescription).")
        }
    }
    
    func updateSegmentStocks(key: String, stocks: [Stock]){
        do {
            let fetchRequest: NSFetchRequest<SegmentCore> = SegmentCore.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "key LIKE %@", key)
            let segment: SegmentCore? = try viewContext.fetch(fetchRequest).first
            for oldStock:StockCore in (segment?.segmentStocks ?? []) as! Set<StockCore>{
                segment?.removeFromSegmentStocks(oldStock)
            }
            for stock in stocks{
                let newStock = StockCore(context: viewContext)
                newStock.cod = stock.cod
                newStock.def = stock.def
                newStock.tke = stock.tke
                newStock.gro = stock.gro
                newStock.stockToSegment = segment
                segment?.addToSegmentStocks(newStock)
            }
            save()
            
        }catch{
            print("An error occured while changing stocks \(error.localizedDescription).")
        }
    }
    
    
}
