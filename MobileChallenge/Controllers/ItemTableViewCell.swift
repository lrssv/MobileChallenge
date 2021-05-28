import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbItemName: UILabel!
    @IBOutlet weak var lbItemValue: UILabel!
    @IBOutlet weak var lbItemAmount: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with item: Items){
        
        let value = Double(item.value)/100
        let valueShow = String(format: "%.2f", value)
        
        lbItemName.text = item.name
        lbItemValue.text = "R$ \(valueShow)"
        lbItemAmount.text = "\(item.amount)"
        lbTotal.text = "R$ \(item.total)"
    }
}
