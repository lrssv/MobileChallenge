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
        
        let first_name = name.components(separatedBy: " ")[0]
        let last_name = name.components(separatedBy: " ")[1]
        
        tfInitials.text = first_name.first!.uppercased() + last_name.first!.uppercased()
        
        tfName.text = name
        if let customerCPNJ = customer.juridical_person?.cnpj {
            tfDocument.text = customerCPNJ
        } else {
            tfDocument.text = customer.cpf
        }
        
        
        
        
    }
}
