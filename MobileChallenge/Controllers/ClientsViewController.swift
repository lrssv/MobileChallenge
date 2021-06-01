import UIKit

class ClientsViewController: UIViewController{

    @IBOutlet weak var sbItem: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let config = Configuration.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ClientsViewController: UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = config.getCustomer() {
            return rows.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientsCell", for: indexPath) as! ClientsTableViewCell

        if let savedCustomers = config.getCustomer() {
            let thisCustomer = savedCustomers[indexPath.row]
            cell.prepare(with: thisCustomer)
            return cell
        }
        return cell
    }
}

extension ClientsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let savedCustomers = config.getCustomer() {
            let thisCustomer = savedCustomers[indexPath.row]
            
            let showCustomer = storyboard?.instantiateViewController(identifier: "BankingBilletViewController") as! BankingBilletViewController
            show(showCustomer, sender: self)
            showCustomer.client_name = thisCustomer.name
            showCustomer.client_cpf = thisCustomer.cpf
            showCustomer.client_phone_number = thisCustomer.phone_number
            

            if thisCustomer.juridical_person != nil {
                showCustomer.client_cnpj = thisCustomer.juridical_person!.cnpj
                showCustomer.client_corporate_name = thisCustomer.juridical_person!.corporate_name
                showCustomer.client_type = .juridicalPerson
                showCustomer.client_showFields = 1
            }
        }
    }
}


