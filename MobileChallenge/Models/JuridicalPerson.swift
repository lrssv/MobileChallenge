import Foundation

class JuridicalPerson: Codable {
    
    let corporate_name: String
    let CPNJ: String
        
    init(corporate_name: String, CPNJ: String){
        self.corporate_name = corporate_name
        self.CPNJ = CPNJ
    }
}
