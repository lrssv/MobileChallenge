import Foundation

class Customer: Codable {
    
    let name: String?
    let cpf: String?
    let phone_number: String?
    
    var email: String?
    var address: Address?
    var juridical_person: JuridicalPerson?
    
    init(name: String, cpf: String, phone_number: String ){
        self.name = name
        self.cpf = cpf
        self.phone_number = phone_number
    }
}
 
