import UIKit

enum PersonType {
    case individualPerson
    case juridicalPerson
}


class BankingBilletViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var scForWho: UISegmentedControl!
    @IBOutlet weak var btClients: UIButton!
    
    @IBOutlet weak var swAddFields: UISwitch!
    
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
    
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var btNext: UIButton!
    
    @IBOutlet weak var viewForWho: UIView!
    @IBOutlet weak var viewLegalPerson: UIView!
    @IBOutlet weak var viewAddFiels: UIView!
    @IBOutlet weak var viewAddres: UIView!
    @IBOutlet weak var viewBt: UIView!
    
    @IBOutlet weak var viewTextFieldName: UIView!
    @IBOutlet weak var viewTextFieldCPF: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAtrributes(for: .individualPerson)
        
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
            default:
                showAtrributes(for: .juridicalPerson)
        }
    }

    @IBAction func swAddFields(_ sender: UISwitch) {
        if sender.isOn {
            viewAddres.isHidden = false
        } else {
            viewAddres.isHidden = true
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let validate = ValidateFieldsBankingBillet()
        
        if let name = tfName.text {
            if textField == tfName {
                if validate.validateField(field: name, type: .name){
                    viewTextFieldName.backgroundColor = .systemGreen
                } else {
                    viewTextFieldName.backgroundColor = .systemRed
                }
            }
        }
        
        if let cpf = tfCPF.text {
            if textField == tfCPF {
                if validate.validateField(field: cpf, type: .cpf) {
                    viewTextFieldCPF.backgroundColor = .systemGreen
                } else {
                    viewTextFieldCPF.backgroundColor = .systemRed
                }
            }
        }
        
        
        return true
    }
    
    
    @IBAction func btNextView(_ sender: UIButton) {
        

        /*
        guard let corporate_name = tfCorporateName.text else { return }
        guard let cnpj = tfCNPJ.text else { return }
        guard let street = tfStreet.text else { return }
        let number = Int(tfNumber.text ?? return )
        */
        
        juridical_person = JuridicalPerson(corporate_name: tfCorporateName.text!, cnpj: tfCNPJ.text!)
        address = Address(street: tfStreet.text!, number: Int(tfNumber.text!)!, neighborhood: tfNeighborhood.text!, zipcode: tfCEP.text!, state: tfState.text!)
        customer = Customer(name: tfName.text!, CPF: tfCPF.text!, phoneNumber: tfPhoneNumber.text!)
        
        customer.address = address
        customer.juridicalPerson = juridical_person
        
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



