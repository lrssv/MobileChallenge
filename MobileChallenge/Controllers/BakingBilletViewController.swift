import UIKit

enum PersonType {
    case individualPerson
    case juridicalPerson
}

class BankingBilletViewController: BaseViewController {

    // MARK: - Elements with action
    
    @IBOutlet weak var scForWho: UISegmentedControl!
    @IBOutlet weak var btClients: UIButton!
    @IBOutlet weak var swAddFields: UISwitch!
    
    // MARK: - Text field variables
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfCPF: UITextField!
    @IBOutlet weak var tfCorporateName: UITextField!
    @IBOutlet weak var tfCNPJ: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
   
    @IBOutlet weak var tfStreet: UITextField!
    @IBOutlet weak var tfNumber: UITextField!
    @IBOutlet weak var tfComplement: UITextField!
    @IBOutlet weak var tfNeighborhood: UITextField!
    @IBOutlet weak var tfCEP: UITextField!
    @IBOutlet weak var tfState: UITextField!
    
    //MARK: - Buttons variables
    
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var btNext: UIButton!
    
    // MARK: - Views that make up the stack view
    
    @IBOutlet weak var viewForWho: UIView!
    @IBOutlet weak var viewLegalPerson: UIView!
    @IBOutlet weak var viewAddFiels: UIView!
    @IBOutlet weak var viewAddres: UIView!
    @IBOutlet weak var viewBt: UIView!
    
    // MARK: - Elements of Text field validate
    
    @IBOutlet weak var viewTfName: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfCPF: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfCorporateName: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfCNPJ: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfPhoneNumber: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfEmail: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfStreet: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfNumber: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfComplement: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfNeighborhood: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfCEP: ValidateFieldsBankingBillet!
    @IBOutlet weak var viewTfState: ValidateFieldsBankingBillet!
    
    let validate = ValidateFieldsBankingBillet()
    var nameValidated = false, cpfValidated = false, phone_numberValidated = false, emailValidated = true, corporate_nameValidated = false, cnpjValidated = false, streetValidated = false, numberValidated = false, complementValidated = false, neighboorhoodValidated = false, cepValidated = false, stateValidated = false
    
    var choosen: Bool = false
    var addFieldsIsOn: Bool = false
    
    //MARK: - Elements of Picker View
    
    lazy var pickerViewStates: UIPickerView  = {
        let pickerViewStates = UIPickerView()
        pickerViewStates.delegate  = self
        pickerViewStates.dataSource = self
        return pickerViewStates
    }()
    
    var stateName: [String] = []
    var stateChosen: String?
    var stateInitials: String?
    
    
    // MARK: - Functions about Banking Billet View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAtrributes(for: .individualPerson)
        
        createPickerView()
        btBack.layer.borderWidth = 1
        btBack.layer.borderColor = UIColor.orange.cgColor
        btNext.isEnabled = true
    }
    
    
    func showAtrributes(for person: PersonType){
        switch person {
            case .individualPerson:
                viewForWho?.isHidden = false
                viewLegalPerson?.isHidden = true
                viewAddFiels?.isHidden = false
                viewAddres?.isHidden = true
                viewBt?.isHidden = false
            default:
                viewForWho.isHidden = false
                viewLegalPerson.isHidden = false
                viewAddFiels.isHidden = false
                viewAddres.isHidden = true
                viewBt.isHidden = false
        }
    }
    
    @IBAction func chosedPerson(_ sender: Any) {
        switch scForWho.selectedSegmentIndex {
        case 0:
            showAtrributes(for: .individualPerson)
            swAddFields.isOn = false
        default:
            showAtrributes(for: .juridicalPerson)
            realeaseButton(field: .buttonNotEnable)
            swAddFields.isOn = false
        }
    }
    
    @IBAction func swAddFields(_ sender: UISwitch) {
        if sender.isOn {
            viewAddres.isHidden = false
            addFieldsIsOn = true
        } else {
            viewAddres.isHidden = true
        }
    }
    
    @IBAction func verifyBasicFields(_ textField: UITextField) {
        if let name = tfName.text {
            if textField == tfName {
                nameValidated = validate.validateField(field: name, type: .name)
                validate.changeColorView(response: nameValidated, view: viewTfName)
            }
        }
        
        if let cpf = tfCPF.text {
            if textField == tfCPF {
                tfCPF.text = formatterField(cpf, "cpf")
                cpfValidated = validate.validateField(field: cpf, type: .cpf)
                validate.changeColorView(response: cpfValidated, view: viewTfCPF)
            }
        }
        
        if let phone_number = tfPhoneNumber.text {
            if textField == tfPhoneNumber {
                tfPhoneNumber.text = formatterField(phone_number, "phoneNumber")
                phone_numberValidated = validate.validateField(field: phone_number, type: .phone_number)
                validate.changeColorView(response: phone_numberValidated, view: viewTfPhoneNumber)
            }
        }
        
        if let email = tfEmail.text {
            if textField == tfEmail {
                emailValidated = validate.validateField(field: email, type: .email)
                validate.changeColorView(response: emailValidated, view: viewTfEmail)
            }
        }
        
        realeaseButton(field: .binding)
    }
    
    @IBAction func verifyJuridicalFields(_ textField: UITextField) {
        if let corporate_name = tfCorporateName.text {
            if textField == tfCorporateName {
                corporate_nameValidated = validate.validateField(field: corporate_name, type: .corporate_name)
                validate.changeColorView(response: corporate_nameValidated, view: viewTfCorporateName)
            }
        }
        
        if let cnpj = tfCNPJ.text {
            if textField == tfCNPJ {
                tfCNPJ.text = formatterField(cnpj, "cnpj")
                cnpjValidated = validate.validateField(field: cnpj, type: .cnpj)
                validate.changeColorView(response: cnpjValidated, view: viewTfCNPJ)
            }
        }
        
        realeaseButton(field: .juridicalPerson)
    }
    
    @IBAction func verifyAddFields(_ textField: UITextField) {
        if let street = tfStreet.text {
            if textField == tfStreet {
                streetValidated = validate.validateField(field: street, type: .street)
                validate.changeColorView(response: streetValidated, view: viewTfStreet)
            }
        }
        
        if let number = tfNumber.text {
            if textField == tfNumber {
                numberValidated = validate.validateField(field: number, type: .number)
                validate.changeColorView(response: numberValidated, view: viewTfNumber)
            }
        }
        
        if let complement = tfComplement.text {
            if textField == tfComplement {
                complementValidated = validate.validateField(field: complement, type: .complement)
                validate.changeColorView(response: complementValidated, view: viewTfComplement)
            }
        }
        
        if let neighborhood = tfNeighborhood.text {
            if textField == tfNeighborhood {
                neighboorhoodValidated = validate.validateField(field: neighborhood, type: .neighborhood)
                validate.changeColorView(response: neighboorhoodValidated, view: viewTfNeighborhood)
            }
        }
        
        if let cep = tfCEP.text {
            if textField == tfCEP {
                cepValidated = validate.validateField(field: cep, type: .zipcode)
                validate.changeColorView(response: cepValidated, view: viewTfCEP)
            }
        }
        
        if let state = tfState.text {
            if textField == tfState {
                stateValidated = validate.validateField(field: state, type: .state)
                validate.changeColorView(response: stateValidated, view: viewTfState)
            }
        }
        
        realeaseButton(field: .addedFields)
    }
    
  
    func realeaseButton(field type: FieldsType){
        switch type {
        case .binding:
            if nameValidated && cpfValidated && phone_numberValidated && emailValidated && scForWho.selectedSegmentIndex == 0 {
                btNext.backgroundColor = UIColor(hexString: "#F36F36")
                btNext.isEnabled = true
                choosen = true
            }
        case .juridicalPerson:
            if nameValidated && cpfValidated && phone_numberValidated && emailValidated && corporate_nameValidated && cnpjValidated {
                btNext.backgroundColor = UIColor(hexString: "#F36F36")
                btNext.isEnabled = true
            }
        case .addedFields:
            if choosen && streetValidated && numberValidated && complementValidated && neighboorhoodValidated && cepValidated && stateValidated && emailValidated  {
                btNext.backgroundColor = UIColor(hexString: "#F36F36")
                btNext.isEnabled = true
            }
        default:
            btNext.backgroundColor = .lightGray
            btNext.isEnabled = false
        }
    }
    
    @IBAction func btNextView(_ sender: UIButton) {
        var cpfString = tfCPF.text!
        cpfString = cpfString.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        cpfString = cpfString.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        var phoneNumberString = tfPhoneNumber.text!
        phoneNumberString = phoneNumberString.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
        phoneNumberString = phoneNumberString.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
        phoneNumberString = phoneNumberString.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        phoneNumberString = phoneNumberString.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        var cepString = tfCEP.text!
        cepString = cepString.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        cepString = cepString.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        customer = Customer(name: tfName.text!, cpf: cpfString, phone_number: phoneNumberString)
        
        if addFieldsIsOn {
            address = Address(street: tfStreet.text!, number: tfNumber.text!, neighborhood: tfNeighborhood.text!, zipcode: cepString, state: stateInitials!)
            customer.address = address
        }
        
        if scForWho.selectedSegmentIndex == 1 {
            juridical_person = JuridicalPerson(corporate_name: tfCorporateName.text!, cnpj: tfCNPJ.text!)
            customer.juridical_person = juridical_person
        }
        
        config.setCustomer(customer: customer)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ItemsViewController
        vc.customer = customer
    }
    
    
    @IBAction func btClientsView(_ sender: UIButton) {
        let client = storyboard?.instantiateViewController(identifier: "ClientsViewController") as! ClientsViewController
        show(client, sender: self)
    }
    
    func formatterField(_ number: String, _ type: String) -> String {
        let cleanNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var format: [Character]
        
        switch type {
        case "phoneNumber":
            format = ["(", "X", "X", ")", " ", "X", " ", "X", "X", "X", "X", "-", "X", "X", "X", "X"]
        case "cpf":
            format = ["X", "X", "X", ".", "X", "X", "X", ".", "X", "X", "X", "-", "X", "X"]
        case "cnpj":
            format = ["X", "X", ".", "X", "X", "X", ".", "X", "X", "X", "/", "X", "X", "X", "X", "-", "X", "X"]
        default:
            return ""
        }
        
        var result = ""
        var index = cleanNumber.startIndex
        for ch in format {
            if index == cleanNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanNumber[index])
                index = cleanNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    // MARK: - Keyboard configuration
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - States Picker View
    func createPickerView(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDiscount))
        toolbar.items = [btCancel, btFlexibleSpace, btDone]
        
        tfState.inputAccessoryView = toolbar
        tfState.inputView = pickerViewStates
        tfState.tintColor = UIColor.clear
    }
    
    @objc func cancel() {
        tfState.resignFirstResponder()
    }
    
    @objc func doneDiscount() {
        stateChosen = stateName[pickerViewStates.selectedRow(inComponent: 0)]
        tfState.text = stateChosen
        
        for (key, value) in states {
            if value == stateChosen {
                stateInitials = key
            }
        }

        cancel()
    }
    
}


// MARK: - Extensions
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

extension BankingBilletViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        for i in states {
            stateName.append(i.value)
        }
        
        return stateName[row]
    }
}


