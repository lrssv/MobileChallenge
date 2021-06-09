import UIKit
import SafariServices

class ShowBankingBilletViewController: BaseViewController {
    // MARK: - Show Bankiing Billet variables
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPaycode: UILabel!
    
    @IBOutlet weak var btShow: UIButton!
    @IBOutlet weak var btShare: UIButton!
    @IBOutlet weak var btCopy: UIButton!
    
    // MARK: - Functions for Show Banking Billet
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.title = "EMISSAO DE BOLETO"
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        buttonsCustom()
        showData()
    }
    
    func buttonsCustom(){
        btShow.layer.borderWidth = 1
        btShow.layer.borderColor = UIColor(hexString: "##1DB4C4").cgColor
        
        btShare.layer.borderWidth = 1
        btShare.layer.borderColor = UIColor(hexString: "##1DB4C4").cgColor
        
        btCopy.layer.borderWidth = 1
        btCopy.layer.borderColor = UIColor(hexString: "##1DB4C4").cgColor
    }
    
    func showData(){
        lbDate.text = convertDateFormater(payment.banking_billet.expire_at)
        lbValue.text = numberFormatter(number: String(totalBankingBillet))
        lbName.text = payment.banking_billet.customer.name
        lbPaycode.text = barcode
    }
    
    @IBAction func copyCode(_ sender: UIButton) {
        UIPasteboard.general.string = barcode
        let alert = UIAlertController(title: "Código de barras copiado", message: nil, preferredStyle: .alert)
        self.present(alert, animated: true, completion: {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertClose)))
        })
        
    }
    
    @objc func alertClose(gesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareCode(_ sender: UIButton) {
        let activityVC = UIActivityViewController(activityItems: [barcode], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
            present(activityVC, animated: true, completion: nil)
        
            activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
                if completed  {
                    self.dismiss(animated: true, completion: nil)
                }
            }
    }
    
    @IBAction func seeBankingBillet(_ sender: UIButton) {
        let url = URL(string: link)
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }
    
    @IBAction func btBack(_ sender: UIButton) {
        let client = storyboard?.instantiateViewController(identifier: "BankingBilletViewController") as! BankingBilletViewController
        show(client, sender: self)
    }
    
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return  dateFormatter.string(from: date!)
    }
}

