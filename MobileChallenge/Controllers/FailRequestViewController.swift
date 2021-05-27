//
//  FailRequestViewController.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 27/05/21.
//

import UIKit

class FailRequestViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = " "
        self.title = "EMISSAO DE BOLETO"
     
    }
    
    @IBAction func btBack(_ sender: UIButton) {
        if let vc = navigationController?.viewControllers.filter({$0 is BankingBilletViewController}).first as? BankingBilletViewController {
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }

}



