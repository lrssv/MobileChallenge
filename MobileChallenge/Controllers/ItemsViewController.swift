import UIKit

class ItemsViewController: BaseViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btNext: UIButton!
    
    var numberOfRows: Int = 0
    
    // MARK: - Functions about the Items View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btNext.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableview.reloadData()
        realeaseButton()
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let addItem = storyboard?.instantiateViewController(identifier: "AddItemViewController") as! AddItemViewController
        addItem.modalPresentationStyle = .fullScreen
        addItem.delegate = self
        present(addItem, animated: true, completion: nil)
    }
    
    func realeaseButton(){
        if items.count >= 1 {
            btNext.backgroundColor = UIColor(hexString: "#F36F36")
            btNext.isEnabled = true
        } else {
            btNext.backgroundColor = .lightGray
            btNext.isEnabled = false
        }
    }
    
    @IBAction func backToView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchItem(_ sender: UIButton) {
        let client = storyboard?.instantiateViewController(identifier: "SavedItemsViewController") as! SavedItemsViewController
        show(client, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddFieldsViewController
        vc.items = items
        vc.customer = customer
    }
}


// MARK: - Extensions
extension ItemsViewController: AddItemDelegate {
    func prepareItems(added item: Items) {
        items.append(item)
        numberOfRows = items.count
    }
}

extension ItemsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        
        let itemCell = items[indexPath.row]
        cell.prepare(with: itemCell)
        
        return cell
    }
}

extension ItemsViewController: UITableViewDelegate{
}

