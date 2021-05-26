import Foundation
import UIKit



class ValidateFieldsItems: UIView {
    
    var result: Bool = false
    
    func validateField(field: UITextField, type: InputType) -> Bool {
        switch type {
        case .name:
            if field.text!.count > 1 && field.text!.count <= 255 { result = true } else { result = false }
        case .value:
            var valueItem = field.text!
            valueItem = valueItem.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            valueItem = valueItem.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
            valueItem = valueItem.replacingOccurrences(of: "R$", with: "", options: NSString.CompareOptions.literal, range: nil)
            if field.text!.count >= 1 && valueItem.isInt { result = true } else { result = false }
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
