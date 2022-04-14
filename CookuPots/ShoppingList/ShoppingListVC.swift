//
//  ShoppingListVC.swift
//  CookuPots
//
//  Created by Sebulla on 11/04/2022.
//

import UIKit

class ShoppingListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = {
    let table = UITableView()
        table.register(ShoppingListCell.self, forCellReuseIdentifier: "cellId")
        return table
    }()
    
    private var savedIngredients: [Ingredient] = [] {
        didSet {
            tableView.reloadData()
            
        }
    }
    private let dataController: DataController
   
    
    init(dataController: DataController) {
        self.dataController = dataController
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        configureTableView()
        do {
            savedIngredients = try dataController.fetchIngredients()
        } catch(let error) {
            print(error)
        }
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        return savedIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = savedIngredients[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: delete from list
    }
}
