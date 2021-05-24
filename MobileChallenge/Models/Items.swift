import Foundation

class Items: Codable {
    
    let name: String
    let value: Int
    let amount: Int
    var total: Double?
    
    init(name: String, value: Int, amount: Int){
        self.name = name
        self.value = value
        self.amount = amount
    }
}
