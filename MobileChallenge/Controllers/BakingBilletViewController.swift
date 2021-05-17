import UIKit

enum PersonType {
    case individualPerson
    case juridicalPerson
}

class BankingBilletViewController: BaseViewController {

    @IBOutlet weak var scForWho: UISegmentedControl!
    @IBOutlet weak var btClients: UIButton!
    
    @IBOutlet weak var swAddFields: UISwitch!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfCPF: UITextField!
    @IBOutlet weak var tfSocialReason: UITextField!
    @IBOutlet weak var tfCNPJ: UITextField!
    @IBOutlet weak var tfCellPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
   
    @IBOutlet weak var tfAddres: UITextField!
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
    
    @IBAction func btNextView(_ sender: UIButton) {
        bankingbillet = BankingBillet(personType: scForWho.selectedSegmentIndex, name: tfName.text!, CPF: tfCPF.text!, socialReason: tfSocialReason.text!, CNPJ: tfCNPJ.text!, cellPhone: tfCellPhone.text!, email: tfEmail.text!, adress: tfAddres.text!, adressNumber: Int(tfNumber.text!), adressComplement: tfComplement.text!, adressNeighborhood: tfNeighborhood.text!, CEP: tfCEP.text!, state: tfState.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ItemsViewController
        vc.bankingbillet = bankingbillet
    }
    
    @IBAction func btClientsView(_ sender: UIButton) {
        let client = storyboard?.instantiateViewController(identifier: "ClientsViewController") as! ClientsViewController
        present(client, animated: true, completion: nil)
    }
    
}
