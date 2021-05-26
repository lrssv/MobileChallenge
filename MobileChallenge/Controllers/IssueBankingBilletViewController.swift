import UIKit

class IssueBankingBilletViewController: BaseViewController, AuthenticationDelagate {
    
    var authentication = Authentication()
    var access_token: String = ""
    var code: String = ""
    var barcode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authentication.delegate = self
        authentication.auth()
    }
    
    func authDelegate(auth: Authentication, token: String) {
        access_token = token
        
        payment = Payment(banking_billet: bankingbillet)
        
        chargeOneStep = CreateChargeOneStep(items: items, payment: payment)
        
        if let shipp = shippings {
            chargeOneStep.shippings = shipp
        }
        
        chargeRequest(body: chargeOneStep)
        
    }
    
    
    func chargeRequest(body: CreateChargeOneStep){
        let route = URL(string: "https://sandbox.gerencianet.com.br/v1/charge/one-step")!
        print(access_token)
        var request = URLRequest(url: route)
        request.httpMethod = "POST"
        
        do {
            let jsonEncoder = JSONEncoder()
            let body = try jsonEncoder.encode(body)
            request.httpBody = body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue(access_token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            print(responseJSON!)
            self.code = responseJSON!["code"] as? String ?? ""
            let boolValue = ((responseJSON!["data"] as? [String: Any])?["barcode"]) as? String
   
        }
        
        task.resume()
    }
    
}
    

