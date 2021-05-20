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
 
    
}
