import UIKit

class IssueBankingBilletViewController: BaseViewController, AuthenticationDelagate {
    
    var authentication = Authentication()
    var access_token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authentication.delegate = self
        authentication.auth()
    }
    
    func authDelegate(auth: Authentication, token: String) {
        access_token = token
        
        payment = Payment(banking_billet: bankingbillet)
        
        chargeOneStep = CreateChargeOneStep(items: items, payment: payment)
        
        if shippings.isEmpty == false {
            chargeOneStep.shippings = shippings
        }
        
        chargeRequest()
        
    }
    
    func chargeRequest(){
        let route = URL(string: "https://sandbox.gerencianet.com.br/v1/charge/one-step")!
        var request = URLRequest(url: route)
        request.httpMethod = "POST"
        
        do {
            let jsonEncoder = JSONEncoder()
            let body = try jsonEncoder.encode(chargeOneStep)
            request.httpBody = body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue(access_token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            
    
            guard let httpResponse = response as? HTTPURLResponse else { return }
                if httpResponse.statusCode == 200 {
                    
                    self.barcode = ((responseJSON!["data"] as? [String: Any])?["barcode"]) as? String ?? ""
                    self.link = ((responseJSON!["data"] as? [String: Any])?["link"]) as? String ?? ""
                    
                    //self.delegateBankingBillet?.chargeOneStepData(from: self, barcode: self.barcode, link: self.link)
                    
                    DispatchQueue.main.async {
                        let showBankingBillet = storyboard?.instantiateViewController(identifier: "ShowDataRequest") as! ShowBankingBilletViewController
                        
                        showBankingBillet.totalBankingBillet = totalBankingBillet
                        showBankingBillet.payment = payment
                        showBankingBillet.barcode = self.barcode
                        showBankingBillet.link = self.link
                        showBankingBillet.chargeOneStep = self.chargeOneStep
                        show(showBankingBillet, sender: self)
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        let failRequest = storyboard?.instantiateViewController(identifier: "FailRequest") as! FailRequestViewController
                        show(failRequest, sender: self)
                    }
                }
            }
            
        task.resume()
    }
}
    

