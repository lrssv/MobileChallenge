import UIKit

class AddItemViewController: BaseViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var tfAmount: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelItem(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
