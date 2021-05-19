import UIKit

protocol AddItemDelegate: class {
    func prepareItems(added item: Items)
}

class AddItemViewController: BaseViewController {
    
    // MARK: - Variables
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var tfAmount: UILabel!
    
    weak var delegate: AddItemDelegate?
    
    var amount: Int = 0
    var totalItem: Double = 0

    // MARK: - Functions about the Add Items View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func removeAmount(_ sender: UIButton) {
        if amount > 0 {
            amount -= 1
        }
        tfAmount.text = String(amount)
    }
    
    @IBAction func addAmount(_ sender: UIButton) {
        amount += 1
        tfAmount.text = String(amount)
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        guard let itemName = tfName.text else { return }
        guard let valueItem = Double(tfValue.text!) else { return }
        
        totalItem = valueItem * Double(amount)
        item = Items(name: itemName, value: valueItem, amount: amount)
        item.total = totalItem

        delegate?.prepareItems(added: item)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelItem(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
