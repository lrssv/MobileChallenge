import UIKit

class SavedItemsViewController: UIViewController {
    
    //MARK: - Saved Items variables
    @IBOutlet weak var searchItem: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    //For get and set in User Defaults
    let config = Configuration.shared
    
    var searching = false
    var savedItems: [Items] = []
    var searchItems: [Items] = []
    
    weak var delegate: AddItemDelegate?
    var indexRemoveItem: Int?
    
    // MARK: - Functions for Saved Items View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        titleBackButton()
        
        //Gets Customers
        if let getItems = config.getItem() {
            savedItems = getItems
        }
    }
}

// MARK: - Extensions
extension SavedItemsViewController: UITableViewDataSource{
    //Table View configurations
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchItems.count
        } else {
            return savedItems.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SavedItemsTableViewCell
  
        var thisItem: Items
        
        if searching {
            thisItem = searchItems[indexPath.row]
        } else {
            thisItem = savedItems[indexPath.row]
        }
        
        cell.prepare(with: thisItem)
        return cell
        
    }
}

extension SavedItemsViewController: UITableViewDelegate{
    //Selects the Item clicked and backs to Items View Controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var thisItem: Items
        
        if searching {
            thisItem = searchItems[indexPath.row]
        } else {
            thisItem = savedItems[indexPath.row]
        }
        
        delegate?.prepareItems(added: thisItem)
        delegate?.removeItem(indexItem: indexRemoveItem)
            
        navigationController?.popViewController(animated: true)
    }
}

extension SavedItemsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searching = false
        } else {
            let filtered = savedItems.filter{ ($0.name.lowercased().contains(searchText.lowercased())) }
            searchItems = filtered.map({($0)})
            
            searching = true
        }
        
        tableview.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableview.reloadData()
    }
}
