import UIKit


class BaseViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Objects for building the request json
    var customer: Customer!
    var juridical_person: JuridicalPerson!
    var address: Address!
    var shipping: Shippings!
    var shippings: [Shippings] = []
    var discount: Discount!
    var conditional_discount: ConditionalDiscount!
    var payment: Payment!
    var chargeOneStep: CreateChargeOneStep!
    var bankingbillet: BankingBillet!
    
    let states = [
        "AC": "Acre",
        "AL": "Alagoas",
        "AP": "Amapá",
        "AM": "Amazonas",
        "BA": "Bahia",
        "CE": "Ceará",
        "DF": "Distrito Federal",
        "ES": "Espírito Santo",
        "GO": "Goiás",
        "MA": "Maranhão",
        "MT": "Mato Grosso",
        "MS": "Mato Grosso do Sul",
        "MG": "Minas Gerais",
        "PA": "Pará",
        "PB": "Paraíba",
        "PR": "Paraná",
        "PE": "Pernambuco",
        "PI": "Piauí",
        "RJ": "Rio de Janeiro",
        "RN": "Rio Grande do Norte",
        "RS": "Rio Grande do Sul",
        "RO": "Rondônia",
        "RR": "Roraima",
        "SC": "Santa Catarina",
        "SP": "São Paulo",
        "SE": "Sergipe",
        "TO": "Tocantins",
    ]
    
    var item: Items!
    var items: [Items] = []
    
    var totalBankingBillet: Double = 0
    
    var barcode: String = ""
    var link: String = ""
    
    // MARK: - Keyboard configuration
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -140 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    

    /*
    func replaceDot(textField field: UITextField) -> String {
        let valueItemDot = field.text!.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        return valueItemDot
    }
    
    func replaceComma(textField field: UITextField) -> String {
        let valueItemComma = field.text!.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        return valueItemComma
    }*/
    
}

