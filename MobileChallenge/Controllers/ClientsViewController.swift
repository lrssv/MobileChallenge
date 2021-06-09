import UIKit

class ClientsViewController: UIViewController{
    //MARK: - Customers variables
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //For save in User Defaults
    let config = Configuration.shared
    
    var searching = false
    var savedCustomers: [Customer] = []
    var searchCustomers: [Customer] = []
    
    // MARK: - Functions for Customers View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Back button navigation configuration
        titleBackButton()
        
        //Gets Customers
        if let getCustomers = config.getCustomer() {
            savedCustomers = getCustomers
        }
    }
    
    //Backs to Banking Billet View Controller and shows Customer data in fields
    func sendData(_ thisCustomer: Customer){
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

// MARK: - Extensions
extension ClientsViewController: UITableViewDataSource  {
    //Customers Table View configuration
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchCustomers.count
        } else {
            return savedCustomers.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientsCell", for: indexPath) as! ClientsTableViewCell
        var thisCustomer: Customer
        
        if searching {
            thisCustomer = searchCustomers[indexPath.row]
        } else {
            thisCustomer = savedCustomers[indexPath.row]
        }
        
        cell.prepare(with: thisCustomer)
        
        return cell
    }
}

extension ClientsViewController: UITableViewDelegate {
    //Selects the Customer clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var thisCustomer: Customer
        
        if searching {
            thisCustomer = searchCustomers[indexPath.row]
        } else {
            thisCustomer = savedCustomers[indexPath.row]
        }
        
        sendData(thisCustomer)
    }
}

extension ClientsViewController: UISearchBarDelegate {
    //Search Bar configuration
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searching = false
        } else {
            let filtered = savedCustomers.filter{ ($0.name.lowercased().contains(searchText.lowercased())) }
            searchCustomers = filtered.map({($0)})
            
            searching = true
        }
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}


