import Foundation

class BankingBillet {
    
    let personType: Int
    let name: String
    let CPF: String
    let socialReason: String?
    let CNPJ: String?
    let cellPhone: Int
    let email: String
    let adress: String?
    let adressNumber: Int?
    let adressComplement: String?
    let adressNeighborhood: String?
    let CEP: String?
    let state: String?
    
    init(personType: Int, name: String, CPF: String, socialReason: String?, CNPJ: String?, cellPhone: Int, email: String, adress: String?, adressNumber: Int?, adressComplement: String?, adressNeighborhood: String?, CEP: String?, state: String?){
        self.personType = personType
        self.name = name
        self.CPF = CPF
        self.socialReason = socialReason
        self.CNPJ = CNPJ
        self.cellPhone = cellPhone
        self.email = email
        self.adress = adress
        self.adressNumber = adressNumber
        self.adressComplement = adressComplement
        self.adressNeighborhood = adressNeighborhood
        self.CEP = CEP
        self.state = state
    }
}
