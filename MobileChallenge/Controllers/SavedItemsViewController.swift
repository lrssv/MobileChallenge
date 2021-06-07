import UIKit

class SavedItemsViewController: UIViewController {

    @IBOutlet weak var searchItem: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    let config = Configuration.shared
    
    weak var delegate: AddItemDelegate?
    var indexRemoveItem: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleBackButton()
    }
    
}

extension SavedItemsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = config.getItem() {
            return rows.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SavedItemsTableViewCell
        
        if let savedItems = config.getItem() {
            let thisItem = savedItems[indexPath.row]
            cell.prepare(with: thisItem)
            
            return cell
        }
        return cell
        
    }
}

extension SavedItemsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let savedItems = config.getItem() {
            let thisItem = savedItems[indexPath.row]
            
            delegate?.prepareItems(added: thisItem)
            delegate?.removeItem(indexItem: indexRemoveItem)
            
            navigationController?.popViewController(animated: true)
        }
    }
}

