import Foundation
import UIKit

class ValidateFieldsAddFields: UITextField {
    
    var result: Bool = false
    
    func validateField(field: String, type: InputType) -> Bool {
        switch type {
        case .date:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let chosenDay: Date = dateFormatter.date(from: field)! as Date
            let toDay = Date()
            if chosenDay > toDay { result = true } else { result = false}
        case .shipping:
            if field.isInt && field.count > 1 { result = true } else { result = false }
        case .typeOf_discount:
            if field != "" { result = true } else { result = false }
        case .discount:
            if field.isInt && field.count > 1 { result = true } else { result = false }
        case .typeOf_conditional_discount:
            if field != "" { result = true } else { result = false }
        case .conditional_discount:
            if field.isInt && field.count > 1 { result = true } else { result = false }
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
