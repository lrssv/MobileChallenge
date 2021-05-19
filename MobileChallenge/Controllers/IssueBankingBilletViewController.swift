//
//  IssueBankingBilletViewController.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 18/05/21.
//

import UIKit

class IssueBankingBilletViewController: BaseViewController {
    
    let route = URL(string: "https://sandbox.gerencianet.com.br/v1/charge/one-step")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func chargeCreate(){
        payment = Payment(banking_billet: bankingbillet)
        
        chargeOneStep = CreateChargeOneStep(items: items, payment: payment)
        chargeOneStep.shippings = shippings
    }
    
    func chargeRequest(){
  
    }
    
}
