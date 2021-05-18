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
    @IBOutlet weak var btAddShipping: UITextField!
    @IBOutlet weak var tfAddShipping: UITextField!
    @IBOutlet weak var tfDateShipping: UITextField!
    @IBOutlet weak var btDateShipping: UIButton!
    @IBOutlet weak var tfObs: UITextField!
    
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
        addFields = AddFields(date: tfDate.text!, shipping: tfShipping.text!, discount: Double(tfDiscount.text!)!, addDiscount: Double(tfDiscount.text!)!, dateShipping: tfDateShipping.text!, textObs: tfObs.text!, total: Double(tfTotal.text!)!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! IssueBankingBilletViewController
        vc.addFields = addFields
    }
    
    
    @IBAction func backToView(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)     
    }
    
}
