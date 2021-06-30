import Foundation

class Token: Codable {
    var access_token: String
    var token_type: String
    
    
    init(access_token: String, token_type: String){
        self.access_token = access_token
        self.token_type = token_type
    }
}
