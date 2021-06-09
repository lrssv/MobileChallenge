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
    
    @IBOutlet weak var viewTfName: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfCPF: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfCorporateName: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfCNPJ: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfPhoneNumber: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfEmail: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfStreet: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfNumber: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfComplement: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfNeighborhood: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfCEP: ValidatesFieldsBankingBillet!
    @IBOutlet weak var viewTfState: ValidatesFieldsBankingBillet!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCPF: UILabel!
    @IBOutlet weak var lbCorporateName: UILabel!
    @IBOutlet weak var lbCNPJ: UILabel!
    @IBOutlet weak var lbPhoneNumber: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbStreet: UILabel!
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var lbComplement: UILabel!
    @IBOutlet weak var lbNeighborhood: UILabel!
    @IBOutlet weak var lbCEP: UILabel!
    
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var views: [UIView]!
    
    let validates = ValidatesFieldsBankingBillet()
    let changes = ChangesColorAccordingToValidation()
    
    var nameValidated = false, cpfValidated = false, phoneNumberValidated = false, emailValidated = true, corporateNameValidated = false, cnpjValidated = false, streetValidated = false, numberValidated = false, complementValidated = false, neighboorhoodValidated = false, cepValidated = false, stateValidated = false
    
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
    
    // MARK: - Variables for Customers List
    
    var client_name = ""
    var client_cpf = ""
    var client_cnpj = ""
    var client_phone_number = ""
    var client_corporate_name = ""
    var client_type: PersonType = .individualPerson
    var client_showFields = 0
    

    // MARK: - Functions for Banking Billet View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        showAtrributes(for: .individualPerson)
        buttonStyleFormatter(inThis: btBack)
        realeaseButton(field: .buttonNotEnable)
        createPickerView()
        
      
    }
    
    //Code for when are a customer chosen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cleanFields()
        
        //Fills the fields with blank when there's no customer select, and when the customer are select fills with values chosen
        tfName.text = client_name
        tfCPF.text = formatterField(client_cpf, "cpf")
        tfCNPJ.text = formatterField(client_cnpj, "cnpj")
        tfCorporateName.text = client_corporate_name
        tfPhoneNumber.text = formatterField(client_phone_number, "phoneNumber")
        
        //Shows the type of customer chosen in Customer View
        scForWho.selectedSegmentIndex = client_showFields
        showAtrributes(for: client_type)
        
        //Validates the fields and releases the button when a saved customer is selected
        if client_name != "" {
            nameValidated = true
            changes.fieldColor(result: nameValidated, label: lbName, view: viewTfName)
            
            cpfValidated = true
            changes.fieldColor(result: cpfValidated, label: lbCPF, view: viewTfCPF)
            
            phoneNumberValidated = true
            changes.fieldColor(result: phoneNumberValidated, label: lbPhoneNumber, view: viewTfPhoneNumber)
            
            realeaseButton(field: .required)
        }
        
        if client_cnpj != "" {
            cnpjValidated = true
            changes.fieldColor(result: cnpjValidated, label: lbCNPJ, view: viewTfCNPJ)
            
            corporateNameValidated = true
            changes.fieldColor(result: corporateNameValidated, label: lbCorporateName, view: viewTfCorporateName)
            
            realeaseButton(field: .juridicalPerson)
        }
    }
    
    //Cleans the fields when the type of person is change
    func cleanFields(){
        for textField in textFields {
            textField.text = ""
        }
        
        for label in labels {
            label.text = ""
        }
        
        for view in views {
            view.backgroundColor = UIColor(hexString: "#DBDBDB")
        }
    }
    
    //Shows fields for each type of person
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
    
    //Styles the view according person type
    @IBAction func chosenPerson(_ sender: Any) {
        switch scForWho.selectedSegmentIndex {
        case 0:
            cleanFields()
            showAtrributes(for: .individualPerson)
            swAddFields.isOn = false
            realeaseButton(field: .required)
        default:
            cleanFields()
            showAtrributes(for: .juridicalPerson)
            realeaseButton(field: .buttonNotEnable)
            swAddFields.isOn = false
        }
    }
    
    //Shows or hidden the additional fields
    @IBAction func swAddFields(_ sender: UISwitch) {
        if sender.isOn {
            viewAddres.isHidden = false
            addFieldsIsOn = true
            realeaseButton(field: .addFields)
        } else {
            viewAddres.isHidden = true
            addFieldsIsOn = false
            realeaseButton(field: .required)
            realeaseButton(field: .juridicalPerson)
        }
    }
    
    //Releases the button according the field type edited
    func realeaseButton(field type: FieldsType){
        switch type {
        case .required:
            if nameValidated && cpfValidated && phoneNumberValidated && emailValidated && scForWho.selectedSegmentIndex == 0 {
                changesReleaseButton(in: btNext)
                choosen = true
            }
        case .juridicalPerson:
            if nameValidated && cpfValidated && phoneNumberValidated && corporateNameValidated && cnpjValidated {
                changesReleaseButton(in: btNext)
                choosen = true
            }
        case .addedFields:
            if choosen && streetValidated && numberValidated && complementValidated && neighboorhoodValidated && cepValidated && stateValidated && emailValidated  {
                changesReleaseButton(in: btNext)
                
            } else {
                btNext.backgroundColor = .lightGray
                btNext.isEnabled = false
            }
        default:
            btNext.backgroundColor = .lightGray
            btNext.isEnabled = false
        }
    }
    
    //Builds the Customer and stores the data at UserDefaults
    @IBAction func btNextView(_ sender: UIButton) {
        let cpfTextRequest = replacingOccurrences(fieldText: tfCPF.text!, isCurrency: false)
        let phoneNumberTextRequest = replacingOccurrences(fieldText: tfPhoneNumber.text!, isCurrency: false)
        let cepTextRequest = replacingOccurrences(fieldText: tfCEP.text!, isCurrency: false)
        let cnpjTextRequest = replacingOccurrences(fieldText: tfCNPJ.text!, isCurrency: false)
        
        customer = Customer(name: tfName.text!, cpf: cpfTextRequest, phone_number: phoneNumberTextRequest)
        
        if addFieldsIsOn {
            address = Address(street: tfStreet.text!, number: tfNumber.text!, neighborhood: tfNeighborhood.text!, zipcode: cepTextRequest, state: stateInitials!)
            customer.address = address
        }
        
        if scForWho.selectedSegmentIndex == 1 {
            juridical_person = JuridicalPerson(corporate_name: tfCorporateName.text!, cnpj: cnpjTextRequest)
            customer.juridical_person = juridical_person
        }
        
        config.setCustomer(customer: customer)
        
    }
    
    //Sends Customer object to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ItemsViewController
        vc.customer = customer
    }
    
    //Show the Cients View Controller
    @IBAction func btClientsView(_ sender: UIButton) {
        let client = storyboard?.instantiateViewController(identifier: "ClientsViewController") as! ClientsViewController
        show(client, sender: self)
    }
    
    //Applicates the mask in text fields
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
        case "cep":
            format = ["X","X","X","X","X","-","X", "X","X"]
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
    
    // MARK: - Validation of Text Fields

    @IBAction func verifyBasicFields(_ textField: UITextField) {
        if let name = tfName.text {
            if textField == tfName {
                nameValidated = validates.thisField(field: name, type: .name)
                changes.fieldColor(result: nameValidated, label: lbName, view: viewTfName)
            }
        }
        
        if let cpf = tfCPF.text {
            if textField == tfCPF {
                tfCPF.text = formatterField(cpf, "cpf")
                cpfValidated = validates.thisField(field: cpf, type: .cpf)
                changes.fieldColor(result: cpfValidated, label: lbCPF, view: viewTfCPF)
            }
        }
        
        if let phone_number = tfPhoneNumber.text {
            if textField == tfPhoneNumber {
                tfPhoneNumber.text = formatterField(phone_number, "phoneNumber")
                phoneNumberValidated = validates.thisField(field: phone_number, type: .phone_number)
                changes.fieldColor(result: phoneNumberValidated, label: lbPhoneNumber, view: viewTfPhoneNumber)
            }
        }
        
        if let email = tfEmail.text {
            if textField == tfEmail {
                emailValidated = validates.thisField(field: email, type: .email)
                changes.fieldColor(result: emailValidated, label: lbEmail, view: viewTfEmail)
            }
        }
        
        realeaseButton(field: .required)
    }
    
    @IBAction func verifyJuridicalFields(_ textField: UITextField) {
        if let corporate_name = tfCorporateName.text {
            if textField == tfCorporateName {
                corporateNameValidated = validates.thisField(field: corporate_name, type: .corporate_name)
                changes.fieldColor(result: corporateNameValidated, label: lbCorporateName, view: viewTfCorporateName)
            }
        }
        
        if let cnpj = tfCNPJ.text {
            if textField == tfCNPJ {
                tfCNPJ.text = formatterField(cnpj, "cnpj")
                cnpjValidated = validates.thisField(field: cnpj, type: .cnpj)
                changes.fieldColor(result: cnpjValidated, label: lbCNPJ, view: viewTfCNPJ)
            }
        }
        
        realeaseButton(field: .juridicalPerson)
    }
    
    @IBAction func verifyAddFields(_ textField: UITextField) {
        if let street = tfStreet.text {
            if textField == tfStreet {
                streetValidated = validates.thisField(field: street, type: .street)
                changes.fieldColor(result: streetValidated, label: lbStreet, view: viewTfStreet)
            }
        }
        
        if let number = tfNumber.text {
            if textField == tfNumber {
                numberValidated = validates.thisField(field: number, type: .number)
                changes.fieldColor(result: numberValidated, label: lbNumber, view: viewTfNumber)
            }
        }
        
        if let complement = tfComplement.text {
            if textField == tfComplement {
                complementValidated = validates.thisField(field: complement, type: .complement)
                changes.fieldColor(result: complementValidated, label: lbComplement, view: viewTfComplement)
            }
        }
        
        if let neighborhood = tfNeighborhood.text {
            if textField == tfNeighborhood {
                neighboorhoodValidated = validates.thisField(field: neighborhood, type: .neighborhood)
                changes.fieldColor(result: neighboorhoodValidated, label: lbNeighborhood, view: viewTfNeighborhood)
            }
        }
        
        if let cep = tfCEP.text {
            if textField == tfCEP {
                tfCEP.text = formatterField(cep, "cep")
                cepValidated = validates.thisField(field: cep, type: .zipcode)
                changes.fieldColor(result: cepValidated, label: lbCEP, view: viewTfCEP)
            }
        }
        
        realeaseButton(field: .addedFields)
        
    }
    
    // MARK: - States Picker View
    func createPickerView(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.items = [btCancel, btFlexibleSpace, btDone]
        
        tfState.inputAccessoryView = toolbar
        tfState.inputView = pickerViewStates
        tfState.tintColor = UIColor.clear
    }
    
    @objc func cancel() {
        tfState.resignFirstResponder()
    }
    
    @objc func done() {
        stateChosen = stateName[pickerViewStates.selectedRow(inComponent: 0)]
        tfState.text = stateChosen
        
        for (key, value) in states {
            if value == stateChosen {
                stateInitials = key
            }
        }
        
        stateValidated = true
        changes.fieldColor(result: stateValidated, label: nil, view: viewTfState)
        realeaseButton(field: .addedFields)
        
        cancel()
    }
    
}

// MARK: - Extensions

extension BankingBilletViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let sortedStates = states.sorted(by: <)
        
        for i in sortedStates {
            stateName.append(i.value)
        }
        
        return stateName[row]
    }
}

