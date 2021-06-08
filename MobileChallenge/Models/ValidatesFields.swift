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


// MARK: - Validates fields of Items View Controller

class ValidatesFieldsItems: UIView {
    
    var result: Bool = false
    
    func thisField(field: String, type: InputType) -> Bool {
        switch type {
        case .name:
            if !field.isInt && field.count > 1 && field.count <= 255 { result = true } else { result = false }
        case .value:
            guard let minValue = Int(field) else { return false}
            if minValue >= 500 && field.isInt { result = true } else { result = false }
        default:
            return false
        }

        return result
    }
}


// MARK: - Validates fields of Additional Fields View Controller

class ValidatesFieldsAddFields: UIView {
    
    var result: Bool = false
    
    func thisField(field: String, type: InputType) -> Bool {
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
}

class ChangesColorAccordingToValidation {
    func fieldColor(result: Bool, label: UILabel?, view: UIView) {
        if label != nil {
            if result {
                view.backgroundColor = .systemGreen
                label!.text = ""
            } else {
                view.backgroundColor = .systemRed
                label!.text = "Valor inválido"
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
    
    func fieldColorDate(result: Bool, label: UILabel, view: UIView){
        if result {
            view.backgroundColor = .systemGreen
            label.text = ""
        } else {
            view.backgroundColor = .systemRed
            label.text = "Data inválida"
        }
    }
}
