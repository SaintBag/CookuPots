//
//  ShoppingListVC.swift
//  CookuPots
//
//  Created by Sebulla on 11/04/2022.
//

import UIKit

class ShoppingListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    //    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //    private var models = [ShoppingList]()
    let tableView: UITableView = {
    let table = UITableView()
        table.register(ShoppingListCell.self, forCellReuseIdentifier: "cellId")
        return table
    }()
    
    //TODO: init
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        configureTableView()
    }
    
    @objc func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            
        }))
        present(alert, animated: true)
    }
    
    func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.pinView(to: view)
        
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //TODO: return added ingredients from choosen ingredients
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "ingredient" //TODO: name of choosen ingredients
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: delete from list
        // TODO: mark as done
        // TODO: make it editable? not sure if this is nessesary
       
    }
}
