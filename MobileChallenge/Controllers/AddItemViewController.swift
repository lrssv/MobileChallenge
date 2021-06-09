import UIKit

protocol AddItemDelegate: class {
    func prepareItems(added item: Items)
    func removeItem(indexItem: Int?)
}

class AddItemViewController: BaseViewController {
    
    // MARK: - Variables
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var tfAmount: UILabel!
    
    @IBOutlet weak var lbAddItem: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbValue: UILabel!
    
    @IBOutlet weak var viewTfName: ValidatesFieldsItems!
    @IBOutlet weak var viewTfValue: ValidatesFieldsItems!
    
    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var btBack: UIButton!
    
    weak var delegate: AddItemDelegate?
   
    var titleItem: String = "Adicionar um item"
    var buttonTitle: String = "ADICIONAR"
    var indexRemoveItem: Int?
    var nameItem: String = ""
    var valueItem: String = ""
    var totalItem: Double = 0
    var amount: Int = 1
    
    let validates = ValidatesFieldsItems()
    let changes = ChangesColorAccordingToValidation()
    
    var nameValidated = false, valueValidated = false

    // MARK: - Functions about the Add Items View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonStyleFormatter(inThis: btBack)
        
        btNext.isEnabled = false
        
        lbAddItem.text = titleItem
        tfName.text = nameItem
        tfValue.text = valueItem
        btNext.setTitle(buttonTitle, for: .normal)
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Validates the fields and releases the button when a saved item is selected
        if nameItem != "" {
            nameValidated = true
            validateName()
        }
        
        if valueItem != "" {
            tfValue.text = numberFormatter(number: valueItem)
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
        
        nameValidated = validates.thisField(field: name, type: .name)
        changes.fieldColor(result: nameValidated, label: lbName, view: viewTfName)
    }
    
    func validateItem(){
        guard let value = tfValue.text else { return }
        
        if value.count == 1 {
            let aux = "00\(value)"
            let valueAux = numberFormatter(number: aux)
            tfValue.text = valueAux
            
            changes.fieldColor(result: false, label: lbValue, view: viewTfValue)
        } else {
            valueItem = value
            valueItem = replacingOccurrences(fieldText: valueItem, isCurrency: true)
            
            let aux = numberFormatter(number: valueItem)
            tfValue.text = aux
            
            valueValidated = validates.thisField(field: valueItem, type: .value)
            changes.fieldColor(result: valueValidated, label: lbValue, view: viewTfValue)
        }
    }
    
    @IBAction func verifyFields(_ textField: UITextField) {
        if textField == tfName {
            validateName()
        }

        if textField == tfValue {
            validateItem()
        }
            
        realeaseButton()
    }
    
    func realeaseButton(){
        if nameValidated && valueValidated  {
            changesReleaseButton(in: btNext)
        } else {
            btNext.backgroundColor = .lightGray
            btNext.isEnabled = false
        }
    }
    
    //Builds the Item and stores the data at UserDefaults, and remove item in case of edit button was selected
    @IBAction func addItem(_ sender: UIButton) {
        guard let itemName = tfName.text else { return }
        
        item = Items(name: itemName, value: Int(valueItem)!, amount: amount)
        
        delegate?.prepareItems(added: item)
        delegate?.removeItem(indexItem: indexRemoveItem)
        
        let itemForSave = Items(name: itemName, value: Int(valueItem)!, amount: 1)
        config.setItem(item: itemForSave)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelItem(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

