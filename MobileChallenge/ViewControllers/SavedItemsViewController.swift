//
//  SavedItemsViewController.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 13/05/21.
//

import UIKit

class SavedItemsViewController: UIViewController {

    @IBOutlet weak var searchItem: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension SavedItemsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

extension SavedItemsViewController: UITableViewDelegate{
    
}
