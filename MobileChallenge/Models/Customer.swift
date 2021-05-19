import Foundation

class Customer: Codable {
    
    let name: String
    let CPF: String
    let phoneNumber: String
    
    var email: String?
    var address: Address?
    var juridicalPerson: JuridicalPerson?
    
    init(name: String, CPF: String, phoneNumber: String ){
        self.name = name
        self.CPF = CPF
        self.phoneNumber = phoneNumber
    }
}
