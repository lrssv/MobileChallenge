import UIKit

class ItemsViewController: BaseViewController {
    
    // MARK: - Variables
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var btBack: UIButton!
    
    var numberOfRows: Int = 0
    
    // MARK: - Functions about the Items View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleBackButton()
        
        buttonStyleFormatter(inThis: btBack)
        
        btNext.isEnabled = false
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        tableview.addGestureRecognizer(longPress)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableview.reloadData()
        realeaseButton()
    }
    
    //Shows Add Item View Controller
    @IBAction func addItem(_ sender: UIButton) {
        let addItem = storyboard?.instantiateViewController(identifier: "AddItemViewController") as! AddItemViewController
        addItem.modalPresentationStyle = .fullScreen
        addItem.delegate = self
        present(addItem, animated: true, completion: nil)
    }
    
    //Releases the button according the validation
    func realeaseButton(){
        if items.count >= 1 {
            btNext.backgroundColor = UIColor(hexString: "#F36F36")
            btNext.isEnabled = true
        } else {
            btNext.backgroundColor = .lightGray
            btNext.isEnabled = false
        }
    }
    
    //Backs to Banking Billet View Controller
    @IBAction func backToView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //Shows Saved Items View Controller
    @IBAction func searchItem(_ sender: UIButton) {
        let searchItem = storyboard?.instantiateViewController(identifier: "SavedItemsViewController") as! SavedItemsViewController
        searchItem.delegate = self
        show(searchItem, sender: self)
    }
    
    //Sends Customer and Item object to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddFieldsViewController
        vc.items = items
        vc.customer = customer
    }
    
    //Shows Alert View to edits and changes the Items
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableview)
            if let indexPath = tableview.indexPathForRow(at: touchPoint) {
                let index = indexPath[1]
                
                let options = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let edit = UIAlertAction(title: "Editar", style: .default, handler: { (action) in
                    let editItem = self.storyboard?.instantiateViewController(identifier: "AddItemViewController") as! AddItemViewController
                    editItem.modalPresentationStyle = .fullScreen
                    
                    editItem.delegate = self
                    
                    editItem.titleItem = "Atualizar um item"
                    editItem.buttonTitle = "ATUALIZAR"
                    editItem.nameItem = self.items[index].name
                    editItem.valueItem = String(self.items[index].value)
                    editItem.indexRemoveItem = index
                    
                    self.present(editItem, animated: true, completion: nil)
                })
                options.addAction(edit)
                
                let remove = UIAlertAction(title: "Remover", style: .destructive, handler: { (action) in
                    self.items.remove(at: index)
                    self.tableview.reloadData()
                })
                options.addAction(remove)
                
                let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                options.addAction(cancel)
                
                present(options, animated: true, completion: nil)
            }
        }
    }
}


// MARK: - Extensions
extension ItemsViewController: AddItemDelegate {
    //Save a Item in Items array
    func prepareItems(added item: Items) {
        items.append(item)
    }
    
    //Remove a Item from Items array
    func removeItem(indexItem: Int?) {
        if indexItem != nil {
            items.remove(at: indexItem!)
        }
    }
}

extension ItemsViewController: UITableViewDataSource {
    //Table View configurations
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        
        if items.count != 0 {
            let itemCell = items[indexPath.row]
            cell.prepare(with: itemCell)
        }
        return cell
    }
}

