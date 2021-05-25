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
    
    var access_token: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentication.delegate = self
        authentication.auth()
        chargeCreate()

    }
    
    func authDelegate(auth: Authentication, token: String) {
        access_token = token
        print(access_token!)
        //chargeRequest(access_token: access_token)
    }
    
    func chargeCreate(){
        payment = Payment(banking_billet: bankingbillet)
        
        chargeOneStep = CreateChargeOneStep(items: items, payment: payment)
        chargeOneStep.shippings = shippings
        
    }
    
    
}
    

