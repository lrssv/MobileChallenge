import Foundation
import UIKit

class ValidateFieldsAddFields: UITextField {
    
    var result: Bool = false
    
    func validateField(field: String, type: InputType) -> Bool {
        switch type {
        case .date:
            if field != "" {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let chosenDay: Date = dateFormatter.date(from: field)! as Date
                let toDay = Date()
                    if chosenDay > toDay { result = true } else { result = false}
            }
        case .shipping:
            var shipping_Validated = field
            shipping_Validated = shipping_Validated.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            shipping_Validated = shipping_Validated.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
            shipping_Validated = shipping_Validated.replacingOccurrences(of: "R$", with: "", options: NSString.CompareOptions.literal, range: nil)
            if shipping_Validated.isInt && shipping_Validated.count > 1 { result = true } else { result = false }
        case .typeOf_discount:
            if field != "" { result = true } else { result = false }
        case .discount:
            var discount_Validated = field
            discount_Validated = discount_Validated.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            discount_Validated = discount_Validated.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
            discount_Validated = discount_Validated.replacingOccurrences(of: "R$", with: "", options: NSString.CompareOptions.literal, range: nil)
            if discount_Validated.isInt && discount_Validated.count > 1 { result = true } else { result = false }
        case .typeOf_conditional_discount:
            if field != "" { result = true } else { result = false }
        case .conditional_discount:
            var conditional_discount_Validated = field
            conditional_discount_Validated = conditional_discount_Validated.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            conditional_discount_Validated = conditional_discount_Validated.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
            conditional_discount_Validated = conditional_discount_Validated.replacingOccurrences(of: "R$", with: "", options: NSString.CompareOptions.literal, range: nil)
            if conditional_discount_Validated.isInt && conditional_discount_Validated.count > 1 { result = true } else { result = false }
        case .until_date:
            if field != "" {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let chosenDay: Date = dateFormatter.date(from: field)! as Date
                let toDay = Date()
                if chosenDay > toDay { result = true } else { result = false}
            }
        case .message:
            if field.count >= 1 && field.count <= 100 { result = true } else { result = false}
        default:
            return false
        }
        
        return result
    }
    
    func changeColorView(response: Bool, view: UIView) {
        if response {
            view.backgroundColor = .systemGreen
        } else {
            view.backgroundColor = .systemRed
        }
    }
    
    
}
