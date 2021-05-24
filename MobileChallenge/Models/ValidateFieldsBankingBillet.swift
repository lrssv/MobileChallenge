import Foundation
import UIKit

enum InputType{
    case name
    case cpf
    case phone_number
    case email
    case street
    case number
    case neighborhood
    case zipcode
    case city
    case complement
    case corporate_name
    case cnpj
    case value
}

class ValidateFieldsBankingBillet: UIView {
    
    var result: Bool = false
    var hasLastName: Bool = false
    
    func validateField(field: String, type: InputType) -> Bool {
        switch type {
        case .name:
            hasLastName = field.contains(" ")
            if field.count > 1 && field.count <= 255 && hasLastName { result = true } else { result = false }
        case .cpf:
            if field.isCPF { result = true } else { result = false }
        case .phone_number:
            if field.isInt && field.count == 11 { result = true } else { result = false }
        case .email:
            if field.count > 1 && field.count <= 255 { result = true } else { result = false }
        case .street:
            if field.count > 1 { result = true } else { result = false }
        case .number:
            if field.isInt { result = true } else { result = false }
        case .neighborhood:
            if field.count > 1 { result = true } else { result = false }
        case .zipcode:
            if field.count > 1 && field.count <= 8 { result = true } else { result = false }
        case .city:
            if field.count > 1 { result = true } else { result = false }
        case .complement:
            if field.count > 1 { result = true } else { result = false }
        case .corporate_name:
            if field.count > 1 && field.count <= 255 { result = true } else { result = false }
        default:
            if field.count == 14 { result = true } else { result = false }
        
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


extension String {
  var isCPF: Bool {
      let numbers = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
      guard numbers.count == 11 else { return false }

      let set = NSCountedSet(array: Array(numbers))
      guard set.count != 1 else { return false }

      let i1 = numbers.index(numbers.startIndex, offsetBy: 9)
      let i2 = numbers.index(numbers.startIndex, offsetBy: 10)
      let i3 = numbers.index(numbers.startIndex, offsetBy: 11)
      let d1 = Int(numbers[i1..<i2])
      let d2 = Int(numbers[i2..<i3])

      var temp1 = 0, temp2 = 0

      for i in 0...8 {
          let start = numbers.index(numbers.startIndex, offsetBy: i)
          let end = numbers.index(numbers.startIndex, offsetBy: i+1)
          let char = Int(numbers[start..<end])

          temp1 += char! * (10 - i)
          temp2 += char! * (11 - i)
      }

      temp1 %= 11
      temp1 = temp1 < 2 ? 0 : 11-temp1

      temp2 += temp1 * 2
      temp2 %= 11
      temp2 = temp2 < 2 ? 0 : 11-temp2

      return temp1 == d1 && temp2 == d2
  }
  
  var isInt: Bool {
      return Int(self) != nil
  }
  
  func mask(type: String, character: Character) -> String {
      let num = self.replacingOccurrences(of: "[ˆ0-9]", with: "" ,options: .regularExpression)
      for n in 0..<type.count{
          guard n < num.count else {
              return num
          }
          let index = String.Index(utf16Offset: n, in: self)
          let char = type[index]
          guard char != character else { continue }
      }
      return num
  }
}





