import Foundation

class CreateChargeOneStep: Codable {
    
    let items: [Items]
    var shippings: [Shippings]?
    let payment: Payment
    
    var token: String!
    
    init(items: [Items], payment: Payment){
        self.items = items
        self.payment = payment
    }
    
}
