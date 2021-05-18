import Foundation

class Authentication {
    
    let route = URL(string: "https://sandbox.gerencianet.com.br/v1/authorize")!
    let json: [String: Any] = ["grant_type": "client_credentials"]
    let credentials: String = "Client_Id_5b2592a08221463b11e308f5e9144493d6041524:Client_Secret_b3affe351c8b1edb3753cd04b9f230f021847f0d"
    
    
    func auth(){
        
        let utf8str = credentials.data(using: .utf8)
        let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        var request = URLRequest(url: route)
        request.httpMethod = "POST"
        request.addValue("Basic \(base64Encoded!)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
}

extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
