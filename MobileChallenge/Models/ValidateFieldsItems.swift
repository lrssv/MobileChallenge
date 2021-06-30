import Foundation
import UIKit



class ValidateFieldsItems: UIView {
    
    var result: Bool = false
    
    func validateField(field: String, type: InputType) -> Bool {
        switch type {
        case .name:
            if field.count > 1 && field.count <= 255 { result = true } else { result = false }
        case .value:
            guard let minValue = Int(field) else { return false}
            if minValue >= 500 && field.isInt { result = true } else { result = false }
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
