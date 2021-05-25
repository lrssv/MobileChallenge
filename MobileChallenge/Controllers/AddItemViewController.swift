import UIKit

protocol AddItemDelegate: class {
    func prepareItems(added item: Items)
}

class AddItemViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - Variables
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var tfAmount: UILabel!
    
    @IBOutlet weak var viewTfName: ValidateFieldsItems!
    @IBOutlet weak var viewTfValue: ValidateFieldsItems!
    
    @IBOutlet weak var btNext: UIButton!
    
    weak var delegate: AddItemDelegate?
    
    var amount: Int = 1
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
        if tfName.text != nil {
            if textField == tfName{
                nameValidated = validate.validateField(field: tfName, type: .name)
                validate.changeColorView(response: nameValidated, view: viewTfName)
            }
        }
        
        if tfValue.text != nil {
            if textField == tfValue {
                valueValidated = validate.validateField(field: tfValue, type: .value)
                validate.changeColorView(response: valueValidated, view: viewTfValue)
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
        guard let valueItem = tfValue.text else { return }
        
        var valueItemRequest = valueItem.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        valueItemRequest = valueItem.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        totalItem = Double(valueItem)! * Double(amount)
        
        item = Items(name: itemName, value: Int(valueItemRequest)!, amount: amount)
        item.total = totalItem
        item.valueShow = valueItem

        delegate?.prepareItems(added: item)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelItem(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
