//
//  ItemTableViewCell.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 17/05/21.
//

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
        lbItemName.text = item.name
        lbItemValue.text = String(item.value)
        lbItemAmount.text = String(item.value)
        lbTotal.text = String(item.total)
    }
}
