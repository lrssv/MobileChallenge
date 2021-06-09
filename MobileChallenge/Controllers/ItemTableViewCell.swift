import UIKit

class ItemTableViewCell: UITableViewCell {
    
    // MARK: - Item Table View Cell variables
    @IBOutlet weak var lbItemName: UILabel!
    @IBOutlet weak var lbItemValue: UILabel!
    @IBOutlet weak var lbItemAmount: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    // MARK: - Functions for Item Table View Cell
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Configurates the cell with Item data
    func prepare(with item: Items){
        let formatter = NumberFormatter()
        
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        
        lbItemName.text = item.name
        lbItemValue.text = formatterNumber(number: String(item.value))
        lbItemAmount.text = "\(item.amount)"
        lbTotal.text = formatterNumber(number: String(item.total))
    }
    
    func formatterNumber(number: String) -> String {
        let formatter = NumberFormatter()
        
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")

        let value = Double(number)!/100
        
        if let price = formatter.string(from: NSNumber(value: value)) {
            return price
        } else {
            return ""
        }
    }
}


