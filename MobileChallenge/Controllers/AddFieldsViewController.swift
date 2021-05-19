//
//  AddFieldsViewController.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 14/05/21.
//

import UIKit

class AddFieldsViewController: BaseViewController {

    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewAddFields: UIView!
    @IBOutlet weak var viewButtons: UIView!
    
    @IBOutlet weak var swAddFields: UISwitch!
    
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var btCalendar: UIButton!
    
    @IBOutlet weak var tfShipping: UITextField!
    @IBOutlet weak var btDiscount: UITextField!
    @IBOutlet weak var tfDiscount: UITextField!
    @IBOutlet weak var btConditionalDiscount: UITextField!
    @IBOutlet weak var tfConditionalDiscount: UITextField!
    @IBOutlet weak var tfDateShipping: UITextField!
    @IBOutlet weak var btDateShipping: UIButton!
    @IBOutlet weak var tfMessage: UITextField!
    
    @IBOutlet weak var tfTotal: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAddFields.isHidden = true
    }
    
    @IBAction func addFields(_ sender: UISwitch) {
        if sender.isOn {
            viewAddFields.isHidden = false
        } else {
            viewAddFields.isHidden = true
        }
    }
    
    @IBAction func issueBankingBillet(_ sender: UIButton) {
        shipping = Shippings(value: Int(tfShipping.text!)!)
        shippings.append(shipping)
        discount = Discount(type: "percentage", value: Int(tfDiscount.text!)!)
        conditional_discount = ConditionalDiscount(type: "percentage", value: Int(tfConditionalDiscount.text!)!, until_date: tfDateShipping.text!)
        
        bankingbillet.expire_at = tfDate.text!
        bankingbillet.message = tfMessage.text!
        bankingbillet.discount = discount
        bankingbillet.conditional_discount = conditional_discount
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! IssueBankingBilletViewController
        vc.items = items
        vc.bankingbillet = bankingbillet
        vc.shippings = shippings
    }
    
    
    @IBAction func backToView(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)     
    }
    
}
