import UIKit

protocol AddItemDelegate: class {
    func prepareItems(added item: Items)
}

class AddItemViewController: BaseViewController {
    
    // MARK: - Variables
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var tfAmount: UILabel!
    
    @IBOutlet weak var lbAddItem: UILabel!
    
    @IBOutlet weak var viewTfName: ValidateFieldsItems!
    @IBOutlet weak var viewTfValue: ValidateFieldsItems!
    
    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var btBack: UIButton!
    
    weak var delegate: AddItemDelegate?
    
    var titleItem: String = "Adicionar um item"
    var buttonTitle: String = "ADICIONAR"
    var nameItem: String = ""
    var valueItem: String = ""
    var totalItem: Double = 0
    var amount: Int = 1
    
    let validate = ValidateFieldsItems()
    var nameValidated = false, valueValidated = false

    // MARK: - Functions about the Add Items View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btBack.layer.borderWidth = 1
        btBack.layer.borderColor = UIColor(hexString: "#F36F36").cgColor
        btNext.isEnabled = false
        
        lbAddItem.text = titleItem
        tfName.text = nameItem
        tfValue.text = valueItem
        btNext.setTitle(buttonTitle, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if nameItem != "" {
            nameValidated = true
            validateName()
        }
        
        if valueItem != "" {
            tfValue.text = formatterNumber(number: valueItem)
            valueValidated = true
            validateItem()
        }
        
        realeaseButton()
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
    
    func validateName(){
        guard let name = tfName.text else { return }
        
        nameValidated = validate.validateField(field: name, type: .name)
        validate.changeColorView(response: nameValidated, view: viewTfName)
    }
    
    func validateItem(){
        guard let value = tfValue.text else { return }
        
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
    
    @IBAction func verifyFields(_ textField: UITextField) {
        if textField == tfName {validateName()}

        if textField == tfValue {validateItem()}
            
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
        
        let itemForSave = Items(name: itemName, value: Int(valueItem)!, amount: 1)
        config.setItem(item: itemForSave)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelItem(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

