//
//  Shippings.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 19/05/21.
//

import Foundation

class Shippings: Codable {
    
    let name: String
    let value: Int
    
    init(name: String = "shipping", value: Int){
        self.value = value
        self.name = name
    }
}
