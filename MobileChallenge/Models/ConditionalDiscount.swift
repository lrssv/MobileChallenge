import Foundation

class ConditionalDiscount: Codable {
    let type: String
    let value: Int
    let until_date: String
    
    init(type: String, value: Int, until_date: String){
        self.type = type
        self.value = value
        self.until_date = until_date
    }
}
