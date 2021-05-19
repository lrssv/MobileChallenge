import Foundation

class Discount: Codable {
    let type: String
    let value: Int
    
    init(type: String, value: Int){
        self.type = type
        self.value = value
    }
}
