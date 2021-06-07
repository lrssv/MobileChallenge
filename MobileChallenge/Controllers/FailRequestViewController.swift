import UIKit

class FailRequestViewController: BaseViewController {
    
    @IBOutlet weak var btBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "EMISSAO DE BOLETO"
        
        buttonStyleFormatter(inThis: btBack)
     
    }
    
    @IBAction func btBack(_ sender: UIButton) {
        if let vc = navigationController?.viewControllers.filter({$0 is BankingBilletViewController}).first as? BankingBilletViewController {
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }

}



