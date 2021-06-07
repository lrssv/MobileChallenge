import Foundation
import UIKit

// MARK: - Validates fields of Banking Billet View Controller

class ValidatesFieldsBankingBillet: UIView {
    
    var result: Bool = false
    var hasLastName: Bool = false
    
    func thisField(field: String, type: InputType) -> Bool {
        switch type {
        case .name:
            var completeName: [String] = []
            for name in field.components(separatedBy: " ") {
                if name != "" { completeName.append(name) }
            }
            if field.count > 1 && field.count <= 255 && completeName.count > 1 { result = true } else { result = false }
        case .cpf:
            if field.isCPF { result = true } else { result = false }
        case .phone_number:
            var phone_numberValidated = field
            phone_numberValidated = phone_numberValidated.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
            phone_numberValidated = phone_numberValidated.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
            phone_numberValidated = phone_numberValidated.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
            phone_numberValidated = phone_numberValidated.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
            if phone_numberValidated.isInt && phone_numberValidated.count == 11 { result = true } else { result = false }
        case .email:
            if field.count > 1 && field.count <= 255 { result = true } else { result = false }
        case .street:
            if field.count > 1 { result = true } else { result = false }
        case .number:
            if field.isInt { result = true } else { result = false }
        case .neighborhood:
            if field.count > 1 { result = true } else { result = false }
        case .zipcode:
            var cepValidated = field
            cepValidated = cepValidated.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
            cepValidated = cepValidated.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
            if cepValidated.isInt && cepValidated.count == 8 { result = true } else { result = false }
        case .city:
            if field.count > 1 { result = true } else { result = false }
        case .complement:
            if field.count > 1 { result = true } else { result = false }
        case .state:
            if field.count > 1 { result = true } else { result = false }
        case .corporate_name:
            if field.count > 1 && field.count <= 255 { result = true } else { result = false }
        case .cnpj:
            if field.isCNPJ { result = true } else { result = false }
        default:
            return false
        }
        
        return result
    }
    
   
}

class ChangesColorAccordingToValidation {
    func fieldColor(result: Bool, label: UILabel?, view: UIView) {
        if label != nil {
            if result {
                view.backgroundColor = .systemGreen
                label!.text = ""
            } else {
                view.backgroundColor = .systemRed
                label!.text = "Formato inválido"
            }
        } else {
            if result {
                view.backgroundColor = .systemGreen
            } else {
                view.backgroundColor = .systemRed
            }
        }
    }
    
    func fieldColorDefault(label: UILabel?, view: UIView){
        if label != nil {
            view.backgroundColor = .systemGray
            label!.text = ""
        }
    }
}
