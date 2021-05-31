//
//  SavedItemsViewController.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 13/05/21.
//

import UIKit

class SavedItemsViewController: BaseViewController {

    @IBOutlet weak var searchItem: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}
