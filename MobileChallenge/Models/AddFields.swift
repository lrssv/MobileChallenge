import Foundation

class AddFields {
    
    let date: String
    let shipping: String?
    let discount: Double?
    let addDiscount: Double?
    let dateShipping: String?
    let textObs: String?
    let total: Double
    
    init (date: String, shipping: String, discount: Double, addDiscount: Double, dateShipping: String, textObs: String, total: Double){
        self.date = date
        self.shipping = shipping
        self.discount = discount
        self.addDiscount = addDiscount
        self.dateShipping = dateShipping
        self.textObs = textObs
        self.total = total
    }
}
