//
//  ItemsViewController.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 13/05/21.
//

import UIKit

class ItemsViewController: BaseViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    
    var items: [Items] = []
    var numberOfRows: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let addItem = storyboard?.instantiateViewController(identifier: "AddItemViewController") as! AddItemViewController
        addItem.modalPresentationStyle = .fullScreen
        addItem.delegate = self
        present(addItem, animated: true, completion: nil)
    }
    
    @IBAction func backToView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchItem(_ sender: UIButton) {
        let client = storyboard?.instantiateViewController(identifier: "SavedItemsViewController") as! SavedItemsViewController
        present(client, animated: true, completion: nil)
    }
}

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
        
        let itemCell = items[indexPath.section]
        cell.prepare(with: itemCell)
        
        return cell
    }
}

extension ItemsViewController: UITableViewDelegate{
}

