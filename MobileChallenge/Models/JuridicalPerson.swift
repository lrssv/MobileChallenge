import Foundation

class JuridicalPerson: Codable {
    
    let corporate_name: String
    let cnpj: String
        
    init(corporate_name: String, cnpj: String){
        self.corporate_name = corporate_name
        self.cnpj = cnpj
    }
}
