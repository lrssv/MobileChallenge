import Foundation

class BankingBillet: Codable {
    
    var customer: Customer?
    var expire_at: String?
    var discount: Discount?
    var conditional_discount: ConditionalDiscount?
    var message: String?
    
    init(customer: Customer?, expire_at: String?, discount: Discount?, conditional_discount: ConditionalDiscount?, message: String?){
        self.customer = customer
        self.expire_at = expire_at
        self.discount = discount
        self.conditional_discount = conditional_discount
        self.message = message
    }
}
