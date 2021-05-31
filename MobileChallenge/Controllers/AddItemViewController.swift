import UIKit

protocol AddItemDelegate: class {
    func prepareItems(added item: Items)
}

class AddItemViewController: BaseViewController {
    
    // MARK: - Variables
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var tfAmount: UILabel!
    
    @IBOutlet weak var viewTfName: ValidateFieldsItems!
    @IBOutlet weak var viewTfValue: ValidateFieldsItems!
    
    @IBOutlet weak var btNext: UIButton!
    
    weak var delegate: AddItemDelegate?
    
    var amount: Int = 1
    var valueItem: String = ""
    var totalItem: Double = 0
    
    let validate = ValidateFieldsItems()
    var nameValidated = false, valueValidated = false

    // MARK: - Functions about the Add Items View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btNext.isEnabled = false
        self.tfName.delegate = self
        self.tfValue.delegate = self
    }
    
    @IBAction func removeAmount(_ sender: UIButton) {
        if amount > 0 {
            amount -= 1
        }
        tfAmount.text = String(amount)
    }
    
    @IBAction func addAmount(_ sender: UIButton) {
        amount += 1
        tfAmount.text = String(amount)
    }
    
    @IBAction func verifyFields(_ textField: UITextField) {
        if let name = tfName.text {
            if textField == tfName {
                nameValidated = validate.validateField(field: name, type: .name)
                validate.changeColorView(response: nameValidated, view: viewTfName)
            }
        }
        
        if let value = tfValue.text {
            if textField == tfValue {
                if value.count == 1 {
                    let aux = "00\(value)"
                    let valueAux = formatterNumber(number: aux)
                    tfValue.text = valueAux
                    
                    validate.changeColorView(response: false, view: viewTfValue)
                } else {
                    valueItem = value
                    valueItem = valueItem.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                    valueItem = valueItem.replacingOccurrences(of: "R$", with: "", options: NSString.CompareOptions.literal, range: nil)
                    
                    valueItem = valueItem.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
                    valueItem = String(valueItem.dropFirst())
                    
                    let aux = formatterNumber(number: valueItem)
                    tfValue.text = aux
                    
                    valueValidated = validate.validateField(field: valueItem, type: .value)
                    validate.changeColorView(response: valueValidated, view: viewTfValue)
                }
            }
        }
        
        realeaseButton()
    }
    
    func realeaseButton(){
        if nameValidated && valueValidated  {
            btNext.backgroundColor = UIColor(hexString: "#F36F36")
            btNext.isEnabled = true
        } else {
            btNext.backgroundColor = .lightGray
            btNext.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func addItem(_ sender: UIButton) {
        guard let itemName = tfName.text else { return }
        
        item = Items(name: itemName, value: Int(valueItem)!, amount: amount)
        
        delegate?.prepareItems(added: item)
        
        config.setItem(item: item)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelItem(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func formatterNumber(number: String) -> String {
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
}
