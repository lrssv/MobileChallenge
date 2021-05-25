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
    
    // MARK: - Text field variables
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfShipping: UITextField!
    @IBOutlet weak var tfDiscount: UITextField!
    @IBOutlet weak var tfConditionalDiscount: UITextField!
    @IBOutlet weak var tfDateShipping: UITextField!
    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var tfTotal: UILabel!
    
    // MARK: - Elements of Date Picker
    let datePickerDate = UIDatePicker()
    let datePickerShipping = UIDatePicker()
    let formatter = DateFormatter()
    
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
    
    let type = ["%", "R$"]
    
    
    // MARK: - Functions about Additional Fields View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAddFields.isHidden = true
        
        datePickerDueDate()
        datePickerDateShipping()
        
        createPickerView()
    }
    
    @IBAction func addFields(_ sender: UISwitch) {
        if sender.isOn {
            viewAddFields.isHidden = false
        } else {
            viewAddFields.isHidden = true
        }
    }
    
    
    @IBAction func issueBankingBillet(_ sender: UIButton) {
        shipping = Shippings(value: Int(tfShipping.text!)!)
        shippings.append(shipping)
        discount = Discount(type: "percentage", value: Int(tfDiscount.text!)!)
        conditional_discount = ConditionalDiscount(type: "percentage", value: Int(tfConditionalDiscount.text!)!, until_date: tfDateShipping.text!)
        
        guard let expire_at = tfDate.text else { return }
        guard let message = tfMessage.text else { return }
        
        bankingbillet = BankingBillet(customer: customer, expire_at: expire_at, discount: discount, conditional_discount: conditional_discount, message: message)
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
    
    
    //MARK: - Create Pickers View
    func createPickerView(){
        let toolbarDiscount = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbarDiscount.tintColor = UIColor(named: "main")
        
        let toolbarConditionalDiscount = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbarConditionalDiscount.tintColor = UIColor(named: "main")
        
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let btCancelDiscount = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelDiscount))
        let btDoneDiscount = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDiscount))
        toolbarDiscount.items = [btCancelDiscount, btFlexibleSpace, btDoneDiscount]
        
        let btCancelConditionalDiscount = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelConditionalDiscount))
        let btDoneConditionalDiscount = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneConditionalDiscount))
        toolbarConditionalDiscount.items = [btCancelConditionalDiscount, btFlexibleSpace, btDoneConditionalDiscount]
        
        btDiscount.inputAccessoryView = toolbarDiscount
        btDiscount.inputView = pickerViewDiscount
        btDiscount.tintColor = UIColor.clear
        
        btConditionalDiscount.inputAccessoryView = toolbarConditionalDiscount
        btConditionalDiscount.inputView = pickerViewConditionalDiscount
        btConditionalDiscount.tintColor = UIColor.clear
    }
    
    @objc func cancelDiscount() {
        btDiscount.resignFirstResponder()
        btConditionalDiscount.resignFirstResponder()
    }
    
    @objc func doneDiscount() {
        btDiscount.text = type[pickerViewDiscount.selectedRow(inComponent: 0)]
        cancelDiscount()
    }
    
    @objc func doneConditionalDiscount() {
        btConditionalDiscount.text = type[pickerViewConditionalDiscount.selectedRow(inComponent: 0)]
        cancelConditionalDiscount()
    }
    
    @objc func cancelConditionalDiscount() {
        btDiscount.resignFirstResponder()
        btConditionalDiscount.resignFirstResponder()
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
        
        let doneBtnDate = UIBarButtonItem(barButtonSystemItem: .done , target: nil, action: #selector(donePressedDate))
        
        toolbarDate.setItems([doneBtnDate], animated: true)
        
        tfDate.inputAccessoryView = toolbarDate
        tfDate.inputView = datePickerDate
        
        datePickerDate.datePickerMode = .date
    }
    
    @objc func donePressedDate(){
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yyyy"
        
        tfDate.text = formatter.string(from: datePickerDate.date)
        
        self.view.endEditing(true)
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
        
        let doneBtnDateShipping = UIBarButtonItem(barButtonSystemItem: .done , target: nil, action: #selector(donePressedDateShipping))
        
        toolbarShipping.setItems([doneBtnDateShipping], animated: true)
        
        tfDateShipping.inputAccessoryView = toolbarShipping
        tfDateShipping.inputView = datePickerShipping
        
        datePickerShipping.datePickerMode = .date
    }
    
    @objc func donePressedDateShipping(){
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yyyy"

        tfDateShipping.text = formatter.string(from: datePickerShipping.date)
        
        self.view.endEditing(true)
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
        return type[row]
    }
}
