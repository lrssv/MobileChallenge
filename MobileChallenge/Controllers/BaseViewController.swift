//
//  BaseViewController.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 14/05/21.
//

import UIKit

class BaseViewController: UIViewController {
    

    var customer: Customer!
    var juridical_person: JuridicalPerson!
    var address: Address!
    var shipping: Shippings!
    var shippings: [Shippings] = []
    var discount: Discount!
    var conditional_discount: ConditionalDiscount!
    var payment: Payment!
    var chargeOneStep: CreateChargeOneStep!
    
    
    var bankingbillet: BankingBillet!
    var item: Items!
    var items: [Items] = []
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
}

