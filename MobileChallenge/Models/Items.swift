import Foundation

class Items: Codable {
    
    let name: String
    let value: Int
    let amount: Int
    var valueShow: String {
        let total = Double(self.value) * Double(self.amount)
        return String(total/100)
    }
    
    init(name: String, value: Int, amount: Int){
        self.name = name
        self.value = value
        self.amount = amount
    }
}
