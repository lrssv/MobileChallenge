import Foundation

class RequestChargeOneStep: BaseViewController, AuthenticationDelagate {
    
    var access_token: String!
    var authentication = Authentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentication.delegate = self
        authentication.auth()
    }
    
    func authDelegate(auth: Authentication, token: String) {
        access_token = token
    }
    
    func chargeRequest(body: CreateChargeOneStep){
        let route = URL(string: "https://sandbox.gerencianet.com.br/v1/charge/one-step")!
        
        var request = URLRequest(url: route)
        
        do {
            let jsonEncoder = JSONEncoder()
            let body = try jsonEncoder.encode(chargeOneStep)
            request.httpBody = body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.httpMethod = "POST"
        request.addValue(access_token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(response!)
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
   
        }
        
        task.resume()
    }
}
