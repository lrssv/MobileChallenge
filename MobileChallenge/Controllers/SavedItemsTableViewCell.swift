import UIKit

class SavedItemsTableViewCell: UITableViewCell {
    
    // MARK: - Saved Items Table View Cell variables
    @IBOutlet weak var tfName: UILabel!
    @IBOutlet weak var tfValue: UILabel!
    
    // MARK: - Functions for Saved Items Table View Cell
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with item: Items) {
        tfName.text = item.name
        tfValue.text = formatterNumber(number: String(item.value))
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

