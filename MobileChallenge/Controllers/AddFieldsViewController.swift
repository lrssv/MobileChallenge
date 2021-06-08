import UIKit

class AddFieldsViewController: BaseViewController {
    
    // MARK: - Views that make up the stack view
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewAddFields: UIView!
    @IBOutlet weak var viewButtons: UIView!
    
    // MARK: - Switch and Buttons variables
    @IBOutlet weak var swAddFields: UISwitch!
    @IBOutlet weak var btDiscount: UITextField!
    @IBOutlet weak var btConditionalDiscount: UITextField!
    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var btBack: UIButton!
    
    // MARK: - Text field variables
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfShipping: UITextField!
    @IBOutlet weak var tfDiscount: UITextField!
    @IBOutlet weak var tfConditionalDiscount: UITextField!
    @IBOutlet weak var tfUntilDate: UITextField!
    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var tfTotal: UILabel!
    
    // MARK: - Views and variables for Text Field validation
    @IBOutlet weak var viewTFDate: ValidatesFieldsAddFields!
    @IBOutlet weak var viewTFShipping: ValidatesFieldsAddFields!
    @IBOutlet weak var viewBTDiscount: ValidatesFieldsAddFields!
    @IBOutlet weak var viewTFDiscount: ValidatesFieldsAddFields!
    @IBOutlet weak var viewBTConditionalDiscount: ValidatesFieldsAddFields!
    @IBOutlet weak var viewTFConditionalDiscount: ValidatesFieldsAddFields!
    @IBOutlet weak var viewTFUntilDate: ValidatesFieldsAddFields!
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbShipping: UILabel!
    @IBOutlet weak var lbDiscount: UILabel!
    @IBOutlet weak var lbConditionalDiscount: UILabel!
    @IBOutlet weak var lbUntilDate: UILabel!
    
    var addFieldsIsOn: Bool = false
    var valueShipping: String = ""
    
    let validates = ValidatesFieldsAddFields()
    let changes = ChangesColorAccordingToValidation()
    
    var dateValidated = false, shippingValidated = false, btDiscountValidated = false, discountValidated = false, btConditionalDiscountValidated = false, conditionalDiscountValidated = false, untilDateValidated = false, messageValidated = true, result = false
        
    // MARK: - Elements of Date Picker
    let datePickerDate = UIDatePicker()
    let datePickerShipping = UIDatePicker()
    let formatterForShow = DateFormatter()
    let formatterAPI = DateFormatter()
    
    var dateChosen: String?
    var untilDateChosen: String?
    
    // MARK: - Elements of Picker View
    lazy var pickerViewDiscount: UIPickerView  = {
        let pickerViewDiscount = UIPickerView()
        pickerViewDiscount.delegate  = self
        pickerViewDiscount.dataSource = self
        return pickerViewDiscount
    }()
    
    lazy var pickerViewConditionalDiscount: UIPickerView  = {
        let pickerViewConditionalDiscount = UIPickerView()
        pickerViewConditionalDiscount.delegate  = self
        pickerViewConditionalDiscount.dataSource = self
        return pickerViewConditionalDiscount
    }()
    
    let typeOfDiscount = ["%", "R$"]
    var discountChosen: String?
    var conditionalDiscountChosen: String?
    
    // MARK: - Functions about Additional Fields View
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAddFields.isHidden = true
        
        totalPayment()
        
        datePickerDueDate()
        datePickerDateShipping()
        
        createPickerView()
        
        buttonStyleFormatter(inThis: btBack)
        
        releaseButton(field: .buttonNotEnable)
    }
    
    @IBAction func addFields(_ sender: UISwitch) {
        if sender.isOn {
            viewAddFields.isHidden = false
            addFieldsIsOn = true
            releaseButton(field: .addFields)
        } else {
            viewAddFields.isHidden = true
            addFieldsIsOn = false
            releaseButton(field: .date)
        }
    }
    
    func totalPayment() {
        for i in items {
            totalBankingBillet += Double(i.total)!
        }
        
        let total = numberFormatter(number: String(totalBankingBillet))
            
        tfTotal.text = total
    }
    
    func releaseButton(field type: FieldsType){
        switch type {
        case .date:
            if dateValidated && !addFieldsIsOn {
                btNext.backgroundColor = UIColor(hexString: "#F36F36")
                btNext.isEnabled = true
            } else {
                btNext.backgroundColor = .lightGray
                btNext.isEnabled = false
            }
        case .addFields:
            if shippingValidated && discountValidated && btDiscountValidated && conditionalDiscountValidated && btConditionalDiscountValidated && untilDateValidated {
                btNext.backgroundColor = UIColor(hexString: "#F36F36")
                btNext.isEnabled = true
            } else {
                btNext.backgroundColor = .lightGray
                btNext.isEnabled = false
            }
        default:
            btNext.backgroundColor = .lightGray
            btNext.isEnabled = false
        }
    }
    
    @IBAction func issueBankingBillet(_ sender: UIButton) {
        let shippingValueRequest = replacingOccurrences(fieldText: tfShipping.text!, isCurrency: true)
        
        let discountValueRequest = replacingOccurrences(fieldText: tfDiscount.text!, isCurrency: true)
        
        let conditionalDiscountValueRequest = replacingOccurrences(fieldText: tfConditionalDiscount.text!, isCurrency: true)
        
        guard let dateChosen = dateChosen else { return }
        
        bankingbillet = BankingBillet(customer: customer, expire_at: dateChosen)
        
        if addFieldsIsOn {
            shipping = Shippings(value: Int(shippingValueRequest)!)
            
            shippings.append(shipping)
            
            if discountChosen == "%" {
                discount = Discount(type: "percentage", value: Int(discountValueRequest)!)
            } else {
                discount = Discount(type: "currency", value: Int(discountValueRequest)!)
            }
            
            if conditionalDiscountChosen == "%" {
                conditional_discount = ConditionalDiscount(type: "percentage", value: Int(conditionalDiscountValueRequest)!, until_date: untilDateChosen!)
            } else {
                conditional_discount = ConditionalDiscount(type: "currency", value: Int(conditionalDiscountValueRequest)!, until_date: untilDateChosen!)
            }
            bankingbillet.discount = discount
            bankingbillet.conditional_discount = conditional_discount
            bankingbillet.message = tfMessage.text!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! IssueBankingBilletViewController
        vc.items = items
        vc.bankingbillet = bankingbillet
        vc.shippings = shippings
        vc.totalBankingBillet = totalBankingBillet
    }
    
  
    
    @IBAction func backToView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Validation of Text Fields
    func valueCentsFormatter(field: String) -> String {
        let aux = "00\(field)"
        let valueAux = numberFormatter(number: aux)
        
        return valueAux
    }
    
    func valueCurrencyFormatter(value: String) -> String {
        var valueItem = value
        
        valueItem = valueItem.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        valueItem = valueItem.replacingOccurrences(of: "R$", with: "", options: NSString.CompareOptions.literal, range: nil)
        valueItem = valueItem.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        valueItem = String(valueItem.dropFirst())
    
        return valueItem
    }
    
    @IBAction func validateDate(_ textField: UITextField) {
        if let date = tfDate.text {
            if textField == tfDate {
                dateValidated = validates.thisField(field: date, type: .date)
                changes.fieldColorDate(result: dateValidated, label: lbDate, view: viewTFDate)
                releaseButton(field: .date)
            }
        }
    }
    
    @IBAction func validateAddFields(_ textField: UITextField) {
        if let shipping = tfShipping.text {
            if textField == tfShipping {
                if shipping.count == 1 {
                    tfShipping.text = valueCentsFormatter(field: shipping)
                    changes.fieldColor(result: false, label: lbShipping, view: viewTFShipping)
                } else {
                    let valueShipping = valueCurrencyFormatter(value: shipping)
                    let formattedValue = numberFormatter(number: valueShipping)
                    tfShipping.text = formattedValue
                            
                    shippingValidated = validates.thisField(field: valueShipping, type: .shipping)
                    changes.fieldColor(result: shippingValidated, label: lbShipping, view: viewTFShipping)
                }
            }
        }
                
        if let discount = tfDiscount.text {
            if textField == tfDiscount {
                if discount.count == 1 {
                    tfDiscount.text = valueCentsFormatter(field: discount)
                    changes.fieldColor(result: false, label: lbDiscount, view: viewTFDiscount)
                } else {
                    let valueDiscount = valueCurrencyFormatter(value: discount)
                    let formattedValue = numberFormatter(number: valueDiscount)
                    tfDiscount.text = formattedValue
                            
                    discountValidated = validates.thisField(field: valueDiscount, type: .discount)
                    changes.fieldColor(result: discountValidated, label: lbDiscount, view: viewTFDiscount)
                }
            }
        }
                
        if let conditional_discount = tfConditionalDiscount.text {
            if textField == tfConditionalDiscount {
                if conditional_discount.count == 1 {
                    tfConditionalDiscount.text = valueCentsFormatter(field: conditional_discount)
                    changes.fieldColor(result: false, label: lbConditionalDiscount, view: viewTFConditionalDiscount)
                } else {
                    let valueConditionalDiscount = valueCurrencyFormatter(value: conditional_discount)
                    let formattedValue = numberFormatter(number: valueConditionalDiscount)
                    tfConditionalDiscount.text = formattedValue
                            
                    conditionalDiscountValidated = validates.thisField(field: valueConditionalDiscount, type: .conditional_discount)
                    changes.fieldColor(result: conditionalDiscountValidated, label: lbConditionalDiscount, view: viewTFConditionalDiscount)
                }
            }
        }
        
        if let btdiscount = btDiscount.text {
            if textField == btDiscount {
                btDiscountValidated = validates.thisField(field: btdiscount, type: .typeOf_discount)
                changes.fieldColor(result: btDiscountValidated, label: nil, view: viewBTDiscount)
            }
        }
                
        if let btconditional_discount = btConditionalDiscount.text {
            if textField == btConditionalDiscount {
                btConditionalDiscountValidated = validates.thisField(field: btconditional_discount, type: .typeOf_conditional_discount)
                changes.fieldColor(result: btConditionalDiscountValidated, label: nil, view: viewBTDiscount)
            }
        }
                
        if let until_date = tfUntilDate.text {
            if textField == tfUntilDate {
                untilDateValidated = validates.thisField(field: until_date, type: .until_date)
                changes.fieldColorDate(result: untilDateValidated, label: lbUntilDate, view: viewTFUntilDate)
            }
        }
                
        if let message = tfMessage.text {
            if textField == tfMessage {
                messageValidated = validates.thisField(field: message, type: .message)
                if messageValidated {
                    tfMessage.textColor = .gray
                } else {
                    tfMessage.textColor = .red
                }
            }
        }
        
        releaseButton(field: .addFields)
    }
    
    //MARK: - Create Picker Views
    func createPickerView(){
        let toolbarDiscount = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbarDiscount.tintColor = UIColor(named: "main")
        
        let toolbarConditionalDiscount = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbarConditionalDiscount.tintColor = UIColor(named: "main")
        
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let btCancelDiscount = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDoneDiscount = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDiscount))
        toolbarDiscount.items = [btCancelDiscount, btFlexibleSpace, btDoneDiscount]
        
        let btCancelConditionalDiscount = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDoneConditionalDiscount = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneConditionalDiscount))
        toolbarConditionalDiscount.items = [btCancelConditionalDiscount, btFlexibleSpace, btDoneConditionalDiscount]
        
        btDiscount.inputAccessoryView = toolbarDiscount
        btDiscount.inputView = pickerViewDiscount
        btDiscount.tintColor = UIColor.clear
        
        btConditionalDiscount.inputAccessoryView = toolbarConditionalDiscount
        btConditionalDiscount.inputView = pickerViewConditionalDiscount
        btConditionalDiscount.tintColor = UIColor.clear
    }
    
    @objc func cancel() {
        btDiscount.resignFirstResponder()
        btConditionalDiscount.resignFirstResponder()
    }
    
    @objc func doneDiscount() {
        discountChosen = typeOfDiscount[pickerViewDiscount.selectedRow(inComponent: 0)]
        btDiscount.text = discountChosen
        cancel()
    }
    
    @objc func doneConditionalDiscount() {
        conditionalDiscountChosen = typeOfDiscount[pickerViewConditionalDiscount.selectedRow(inComponent: 0)]
        btConditionalDiscount.text = conditionalDiscountChosen
        cancel()
    }
    
    @objc override func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -50 
    }
    
    // MARK: - Create Date Pickers
    func datePickerDueDate(){
        if #available(iOS 13.4, *) {
            datePickerDate.preferredDatePickerStyle = .wheels
        }
        
        let loc = Locale(identifier: "pt_BR")
        self.datePickerDate.locale = loc
        
        datePickerDate.translatesAutoresizingMaskIntoConstraints = false
        
        let toolbarDate = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100.0, height: 44.0))
        toolbarDate.translatesAutoresizingMaskIntoConstraints = false
        toolbarDate.sizeToFit()
        
        
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btCancelDate = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelDate))
        let doneBtnDate = UIBarButtonItem(barButtonSystemItem: .done , target: nil, action: #selector(donePressedDate))
        
        toolbarDate.setItems([doneBtnDate, btFlexibleSpace, btCancelDate], animated: true)
        
        tfDate.inputAccessoryView = toolbarDate
        tfDate.inputView = datePickerDate
        
        datePickerDate.datePickerMode = .date
    }
    
    @objc func donePressedDate(){
        formatterForShow.dateStyle = .medium
        formatterForShow.timeStyle = .none
        formatterForShow.dateFormat = "dd/MM/yyyy"
        
        tfDate.text = formatterForShow.string(from: datePickerDate.date)
        
        formatterAPI.dateFormat = "YYYY-MM-dd"
        dateChosen = formatterAPI.string(from: datePickerDate.date)
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDate() {
        tfDate.resignFirstResponder()
    }
    
    func datePickerDateShipping(){
        if #available(iOS 13.4, *) {
            datePickerShipping.preferredDatePickerStyle = .wheels
        }
        
        let loc = Locale(identifier: "pt_BR")
        self.datePickerShipping.locale = loc
        
        datePickerShipping.translatesAutoresizingMaskIntoConstraints = false
 
        let toolbarShipping = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100.0, height: 44.0))
        toolbarShipping.translatesAutoresizingMaskIntoConstraints = false
        toolbarShipping.sizeToFit()
        
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btCancelDateShipping = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelDateShipping))
        let doneBtnDateShipping = UIBarButtonItem(barButtonSystemItem: .done , target: nil, action: #selector(donePressedDateShipping))
        
        toolbarShipping.setItems([doneBtnDateShipping, btFlexibleSpace, btCancelDateShipping], animated: true)
        
        tfUntilDate.inputAccessoryView = toolbarShipping
        tfUntilDate.inputView = datePickerShipping
        
        datePickerShipping.datePickerMode = .date
    }
    
    @objc func donePressedDateShipping(){
        formatterForShow.dateStyle = .medium
        formatterForShow.timeStyle = .none
        formatterForShow.dateFormat = "dd/MM/yyyy"

        tfUntilDate.text = formatterForShow.string(from: datePickerShipping.date)
        
        formatterAPI.dateFormat = "YYYY-MM-dd"
        untilDateChosen = formatterAPI.string(from: datePickerDate.date)
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDateShipping() {
        tfUntilDate.resignFirstResponder()
    }
    
}

// MARK: - Extensions

extension AddFieldsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeOfDiscount[row]
    }
}

