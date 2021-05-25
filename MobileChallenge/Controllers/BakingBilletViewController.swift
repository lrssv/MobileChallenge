import UIKit

enum PersonType {
    case individualPerson
    case juridicalPerson
}

enum FieldsType{
    case binding
    case juridicalPerson
    case addedFields
    case buttonNotEnable
}


class BankingBilletViewController: BaseViewController, UITextFieldDelegate {
    
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
    var nameValidated = false, cpfValidated = false, phone_numberValidated = false, emailValidated = false, corporate_nameValidated = false, cnpjValidated = false, streetValidated = false, numberValidated = false, complementValidated = false, neighboorhoodValidated = false, cepValidated = false
    
    
    // MARK: - Functions about Banking Billet View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAtrributes(for: .individualPerson)
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
            realeaseButton(field: .buttonNotEnable)
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
                cpfValidated = validate.validateField(field: cpf, type: .cpf)
                validate.changeColorView(response: cpfValidated, view: viewTfCPF)
            }
        }
        
        if let phone_number = tfPhoneNumber.text {
            if textField == tfPhoneNumber {
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
        
        realeaseButton(field: .addedFields)
    }
    
  
    func realeaseButton(field type: FieldsType){
        var choosen: Bool = false
        
        switch type {
        case .binding:
            if nameValidated && cpfValidated && phone_numberValidated && emailValidated {
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
            if choosen && streetValidated && numberValidated && complementValidated && neighboorhoodValidated && cepValidated {
                btNext.backgroundColor = UIColor(hexString: "#F36F36")
                btNext.isEnabled = true
            }
        default:
            btNext.backgroundColor = .lightGray
            btNext.isEnabled = false
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func btNextView(_ sender: UIButton) {
        address = Address(street: tfStreet.text!, number: tfNumber.text!, neighborhood: tfNeighborhood.text!, zipcode: tfCEP.text!, state: tfState.text!)
        customer = Customer(name: tfName.text!, cpf: tfCPF.text!, phone_number: tfPhoneNumber.text!)
        customer.address = address
        
        if juridical_person != nil {customer.juridical_person = juridical_person} else { return }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ItemsViewController
        vc.customer = customer
    }
    
    @IBAction func btClientsView(_ sender: UIButton) {
        let client = storyboard?.instantiateViewController(identifier: "ClientsViewController") as! ClientsViewController
        present(client, animated: true, completion: nil)
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
