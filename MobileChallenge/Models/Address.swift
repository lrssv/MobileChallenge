import Foundation

class Address: Codable {
    let street: String
    let number: Int
    let neighborhood: String
    let zipcode: String
    let city: String = ""
    var complement: String?
    let state: String
    
    init(street: String, number: Int, neighborhood: String, zipcode: String, state: String){
        self.street = street
        self.number = number
        self.neighborhood = neighborhood
        self.zipcode = zipcode
        self.state = state
    }
}
