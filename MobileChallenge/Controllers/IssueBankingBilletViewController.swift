//
//  IssueBankingBilletViewController.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 18/05/21.
//

import UIKit

class IssueBankingBilletViewController: BaseViewController, AuthenticationDelagate {

    let route = URL(string: "https://sandbox.gerencianet.com.br/v1/charge/one-step")!
    
    var authentication = Authentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentication.delegate = self
        authentication.auth()
    }
    
    func authDelegate(auth: Authentication, token: String) {
        print(token)
    }
    
    func chargeCreate(){
        payment = Payment(banking_billet: bankingbillet)
        
        chargeOneStep = CreateChargeOneStep(items: items, payment: payment)
        chargeOneStep.shippings = shippings
    }
    
    func chargeRequest(){
        
        
    }
    
}
