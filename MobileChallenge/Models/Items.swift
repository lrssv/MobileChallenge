import Foundation

class Items: Codable {
    
    let name: String
    let value: Int
    let amount: Int
    var total: String {
        var total = Double(self.value) * Double(self.amount)
        total = total/100
        return String(format: "%.2f", total)
    }
    
    init(name: String, value: Int, amount: Int){
        self.name = name
        self.value = value
        self.amount = amount
    }
}
