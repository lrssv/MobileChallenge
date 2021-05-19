import Foundation

class Items: Codable {
    
    let name: String
    let value: Double
    let amount: Int
    var total: Double?
    
    init(name: String, value: Double, amount: Int){
        self.name = name
        self.value = value
        self.amount = amount
    }
}
