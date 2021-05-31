import UIKit

class ClientsViewController: BaseViewController {

    @IBOutlet weak var sbItem: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    

}

extension ClientsViewController: UITableViewDataSource{
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClientsTableViewCell
        
        if let savedCustomers = config.getCustomer() {
            let thisCustomer = savedCustomers[indexPath.row]
            cell.prepare(with: thisCustomer)
            return cell
        }
        return cell
        
    }
}

extension ClientsViewController: UITableViewDelegate{
    
}
