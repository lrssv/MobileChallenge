//
//  ItemsViewController.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 13/05/21.
//

import UIKit

class ItemsViewController: BaseViewController {
    
    var items: [Items]!
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let addItem = storyboard?.instantiateViewController(identifier: "AddItemViewController") as! AddItemViewController
        addItem.modalPresentationStyle = .overCurrentContext
        present(addItem, animated: true, completion: nil)
        
    }
    
    @IBAction func backToView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension ItemsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath)
        return cell
    }
}

extension ItemsViewController: UITableViewDelegate{
    
}
