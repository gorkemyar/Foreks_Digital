import Foundation

protocol DataService{
    func load(completion: (()->Void)?)
    func save()
    func getSegments() -> [Segment]
    func addSegment(segment: Segment)
    func updateSegmentName(oldName: String, newName: String)
    func updateSegmentStocks(key: String, stocks: [Stock])
}
