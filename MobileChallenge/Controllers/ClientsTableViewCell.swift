//
//  ClientsTableViewCell.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 31/05/21.
//

import UIKit

class ClientsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tfName: UILabel!
    @IBOutlet weak var tfDocument: UILabel!
    @IBOutlet weak var tfInitials: UILabel!
    
    let config = Configuration.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with customer: Customer){
        let name = customer.name
        tfName.text = name
        
        let first_name = name.components(separatedBy: " ")[0]
        let last_name = name.components(separatedBy: " ").last
        
        tfInitials.text = first_name.first!.uppercased() + (last_name?.first!.uppercased())!
        
        if let customerCPNJ = customer.juridical_person?.cnpj {
            tfDocument.text = formatterString(customerCPNJ,"cnpj")
        } else {
            tfDocument.text = formatterString(customer.cpf, "cpf")
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
