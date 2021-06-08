import UIKit


class BaseViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Objects for building the request json
    var customer: Customer!
    var juridical_person: JuridicalPerson!
    var address: Address!
    var shipping: Shippings!
    var shippings: [Shippings] = []
    var discount: Discount!
    var conditional_discount: ConditionalDiscount!
    var payment: Payment!
    var chargeOneStep: CreateChargeOneStep!
    var bankingbillet: BankingBillet!
    
    let config = Configuration.shared
    
    let states = [
        "AC": "Acre",
        "AL": "Alagoas",
        "AP": "Amapá",
        "AM": "Amazonas",
        "BA": "Bahia",
        "CE": "Ceará",
        "DF": "Distrito Federal",
        "ES": "Espírito Santo",
        "GO": "Goiás",
        "MA": "Maranhão",
        "MT": "Mato Grosso",
        "MS": "Mato Grosso do Sul",
        "MG": "Minas Gerais",
        "PA": "Pará",
        "PB": "Paraíba",
        "PR": "Paraná",
        "PE": "Pernambuco",
        "PI": "Piauí",
        "RJ": "Rio de Janeiro",
        "RN": "Rio Grande do Norte",
        "RS": "Rio Grande do Sul",
        "RO": "Rondônia",
        "RR": "Roraima",
        "SC": "Santa Catarina",
        "SP": "São Paulo",
        "SE": "Sergipe",
        "TO": "Tocantins",
    ]
    
    var item: Items!
    var items: [Items] = []
    
    var totalBankingBillet: Double = 0
    
    var barcode: String = ""
    var link: String = ""
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.tintColor = .white
        
        // Keyboard configuration
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func replacingOccurrences(fieldText: String, isCurrency: Bool) -> String {
        var fieldReplaced = fieldText
        
        fieldReplaced = fieldReplaced.replacingOccurrences(of: "R$", with: "", options: NSString.CompareOptions.literal, range: nil)
        fieldReplaced = fieldReplaced.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        fieldReplaced = fieldReplaced.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        fieldReplaced = fieldReplaced.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        fieldReplaced = fieldReplaced.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
        fieldReplaced = fieldReplaced.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
        fieldReplaced = fieldReplaced.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
        fieldReplaced = fieldReplaced.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        if isCurrency {
            fieldReplaced = String(fieldReplaced.dropFirst())
        }
        
        return fieldReplaced
    }
    
    // MARK: Number formatter to Brazilian Currency
    func numberFormatter(number: String) -> String {
        let formatter = NumberFormatter()
        
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        
        let value = Double(number)!/100
        
        if let price = formatter.string(from: NSNumber(value: value)) {
            return price
        } else {
            return ""
        }
    }
    
    // MARK: Button style formatter
    func buttonStyleFormatter(inThis button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hexString: "#F36F36").cgColor
    }
    
    func changesReleaseButton(in button: UIButton){
        button.backgroundColor = UIColor(hexString: "#F36F36")
        button.isEnabled = true
    }
    
    // MARK: Keyboard configuration
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -140 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    // MARK: - Keyboard configuration
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - Extensions

extension UIViewController {
    func titleBackButton () {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension String {
    var isInt: Bool { return Int(self) != nil }
    
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
    
    var isCNPJ: Bool {
            let numbers = compactMap({ Int(String($0)) })
            guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
            func digitCalculator(_ slice: ArraySlice<Int>) -> Int {
                var number = 1
                let digit = 11 - slice.reversed().reduce(into: 0) {
                    number += 1
                    $0 += $1 * number
                    if number == 9 { number = 1 }
                } % 11
                return digit > 9 ? 0 : digit
            }
            let dv1 = digitCalculator(numbers.prefix(12))
            let dv2 = digitCalculator(numbers.prefix(13))
            return dv1 == numbers[12] && dv2 == numbers[13]
    }
}
