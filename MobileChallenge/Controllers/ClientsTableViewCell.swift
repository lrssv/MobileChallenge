import UIKit

class ClientsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tfName: UILabel!
    @IBOutlet weak var tfDocument: UILabel!
    @IBOutlet weak var lbInitials: UILabel!
    @IBOutlet weak var vwInitials: UIView!
    
    let config = Configuration.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwInitials.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with customer: Customer){
        let name = customer.name
        tfName.text = name
        
        let first_name = name.components(separatedBy: " ")[0]
        let last_name = name.components(separatedBy: " ").last
        
        guard let first_name_initial = first_name.first?.uppercased() else { return }
        guard let last_name_initial = last_name?.first?.uppercased() else { return }
        
        lbInitials.text = first_name_initial + last_name_initial
        tfDocument.text = formatterString(customer.cpf, "cpf")
        
        if let customerCPNJ = customer.juridical_person?.cnpj {
            vwInitials.backgroundColor = .white
            vwInitials.layer.borderWidth = 1
            vwInitials.layer.borderColor = UIColor(hexString: "#1DB4C4").cgColor
            lbInitials.textColor = UIColor(hexString: "#1DB4C4")
            tfDocument.text = formatterString(customerCPNJ,"cnpj")
        } else {
            vwInitials.backgroundColor = UIColor(hexString: "#1DB4C4")
            lbInitials.textColor = .white
        }
    }
    
    func formatterString(_ number: String, _ type: String) -> String {
        let cleanNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var format: [Character]
        
        switch type {
        case "cpf":
            format = ["X", "X", "X", ".", "X", "X", "X", ".", "X", "X", "X", "-", "X", "X"]
        case "cnpj":
            format = ["X", "X", ".", "X", "X", "X", ".", "X", "X", "X", "/", "X", "X", "X", "X", "-", "X", "X"]
        default:
            return ""
        }
        
        var result = ""
        var index = cleanNumber.startIndex
        for ch in format {
            if index == cleanNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanNumber[index])
                index = cleanNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
