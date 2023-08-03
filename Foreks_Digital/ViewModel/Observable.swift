import Foundation

final class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping(T)-> Void){
        listener(value)
        self.listener = listener
    }
}
