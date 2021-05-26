import UIKit

class AddFieldsViewController: BaseViewController {
    
    // MARK: - Views that make up the stack view
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewAddFields: UIView!
    @IBOutlet weak var viewButtons: UIView!
    
    // MARK: - Switch and Buttons variables
    @IBOutlet weak var swAddFields: UISwitch!
    @IBOutlet weak var btCalendar: UIButton!
    @IBOutlet weak var btDateShipping: UIButton!
    @IBOutlet weak var btDiscount: UITextField!
    @IBOutlet weak var btConditionalDiscount: UITextField!
    @IBOutlet weak var btNext: UIButton!
    
    
    // MARK: - Text field variables
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfShipping: UITextField!
    @IBOutlet weak var tfDiscount: UITextField!
    @IBOutlet weak var tfConditionalDiscount: UITextField!
    @IBOutlet weak var tfUntilDate: UITextField!
    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var tfTotal: UILabel!
    
    // MARK: - Views and variables for Text Field validation
    
    @IBOutlet weak var viewTFDate: ValidateFieldsAddFields!
    @IBOutlet weak var viewTFShipping: ValidateFieldsAddFields!
    @IBOutlet weak var viewBTDiscount: ValidateFieldsAddFields!
    @IBOutlet weak var viewTFDiscount: ValidateFieldsAddFields!
    @IBOutlet weak var viewBTConditionalDiscount: ValidateFieldsAddFields!
    @IBOutlet weak var viewTFConditionalDiscount: ValidateFieldsAddFields!
    @IBOutlet weak var viewTFUntilDate: ValidateFieldsAddFields!
    
    var addFieldsIsOn: Bool = false
    
    let validate = ValidateFieldsAddFields()
    
    var dateValidated = false, shippingValidated = false, btDiscountValidated = false, discountValidated = false, btConditionalDiscountValidated = false, conditionalDiscountValidated = false, untilDateValidated = false, messageValidated = true
        
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
        
        btNext.isEnabled = true
    }
    
    
    @IBAction func addFields(_ sender: UISwitch) {
        if sender.isOn {
            viewAddFields.isHidden = false
            addFieldsIsOn = true
        } else {
            viewAddFields.isHidden = true
            addFieldsIsOn = false
        }
    }
    
    @IBAction func validateDate(_ textField: UITextField) {
        if let date = tfDate.text {
            if textField == tfDate {
                dateValidated = validate.validateField(field: date, type: .date)
                validate.changeColorView(response: dateValidated, view: viewTFDate)
            }
        }
        realeaseButton(field: .date)
    }
    
    
    @IBAction func validateAddFields(_ textField: UITextField) {
        if let shipping = tfShipping.text {
            if textField == tfShipping {
                shippingValidated = validate.validateField(field: shipping, type: .shipping)
                validate.changeColorView(response: shippingValidated, view: viewTFShipping)
            }
        }
        
        if let btdiscount = btDiscount.text {
            if textField == btDiscount {
                btDiscountValidated = validate.validateField(field: btdiscount, type: .typeOf_discount)
                validate.changeColorView(response: btDiscountValidated, view: viewBTDiscount)
            }
        }
        
        if let discount = tfDiscount.text {
            if textField == tfDiscount {
                discountValidated = validate.validateField(field: discount, type: .discount)
                validate.changeColorView(response: discountValidated, view: viewTFDiscount)
            }
        }
        
        if let conditional_discount = tfConditionalDiscount.text {
            if textField == tfConditionalDiscount {
                conditionalDiscountValidated  = validate.validateField(field: conditional_discount, type: .typeOf_conditional_discount)
                validate.changeColorView(response: conditionalDiscountValidated, view: viewTFConditionalDiscount)
            }
        }
        
        if let btconditional_discount = btConditionalDiscount.text {
            if textField == btConditionalDiscount {
                btConditionalDiscountValidated = validate.validateField(field: btconditional_discount, type: .typeOf_conditional_discount)
                validate.changeColorView(response: btDiscountValidated, view: viewBTConditionalDiscount)
            }
        }
        
        if let until_date = tfUntilDate.text {
            if textField == tfUntilDate {
                untilDateValidated = validate.validateField(field: until_date, type: .until_date)
                validate.changeColorView(response: untilDateValidated, view: viewTFUntilDate)
            }
        }
        
        if let message = tfMessage.text {
            if textField == tfMessage {
                messageValidated = validate.validateField(field: message, type: .message)
                if messageValidated {
                    tfMessage.textColor = .gray
                } else {
                    tfMessage.textColor = .red
                }
            }
        }
        
        realeaseButton(field: .addFields)
    }
    
    func realeaseButton(field type: FieldsType){
        switch type {
        case .date:
            if dateValidated {
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
    
    
    func totalPayment() {
        var totalBankingBillet: Double = 0
        
        for i in items {
            totalBankingBillet += Double(i.valueShow)!
        }
        
        tfTotal.text = "R$ \(totalBankingBillet)"
    }
    
    
    @IBAction func issueBankingBillet(_ sender: UIButton) {
        var shippingString = tfShipping.text!
        shippingString = shippingString.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        shippingString = shippingString.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        var discountString = tfDiscount.text!
        discountString = discountString.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        discountString  = discountString.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        var conditionalDiscountString = tfConditionalDiscount.text!
        conditionalDiscountString = conditionalDiscountString.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        conditionalDiscountString = conditionalDiscountString.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        bankingbillet = BankingBillet(customer: customer, expire_at: dateChosen!)
        
        if addFieldsIsOn {
            shipping = Shippings(value: Int(shippingString)!)
            shippings.append(shipping)
            
            if discountChosen == "%" {
                discount = Discount(type: "percentage", value: Int(discountString)!)
            } else {
                discount = Discount(type: "currency", value: Int(discountString)!)
            }
            
            if conditionalDiscountChosen == "%" {
                conditional_discount = ConditionalDiscount(type: "percentage", value: Int(conditionalDiscountString)!, until_date: untilDateChosen!)
            } else {
                conditional_discount = ConditionalDiscount(type: "currency", value: Int(conditionalDiscountString)!, until_date: untilDateChosen!)
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
    }
    
    
    @IBAction func backToView(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)     
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

