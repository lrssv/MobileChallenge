import Foundation
import UIKit


class ValidateFieldsItems: UITextField {
    
    var result: Bool = false
    
    func validateField(field: UITextField, type: InputType) -> Bool {
        switch type {
        case .name:
            if field.text!.count > 1 && field.text!.count <= 255 { result = true } else { result = false }
        case .value:
            let valueItemDot = field.text!.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            let valueItemComma = field.text!.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
            if field.text!.count >= 1 && valueItemComma.isInt || valueItemDot.isInt { result = true } else { result = false }
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
