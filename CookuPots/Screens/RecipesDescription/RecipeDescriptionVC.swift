//
//  RecipeDescriptionVC.swift
//  CookuPots
//
//  Created by Sebulla on 29/03/2022.
//

import UIKit
import Kingfisher

// as a table view
// recipe image at the top of view

// ingredients with option to add it to shopping list
// directions

class RecipeDescriptionVC: UIViewController {
    
    private let recipe: Recipe
    private lazy var tableView = UITableView()
    struct CellID {
        static let DescriptionCell = "DescriptionCell"
    }

    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
        print(recipe)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()

    }
    
    func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDelegates()
//        tableView.rowHeight = 100
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: CellID.DescriptionCell)
        tableView.pinDescriptionView(to: view)
        
    }
 
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecipeDescriptionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.DescriptionCell, for: indexPath) as! DescriptionCell
        
        cell.textLabel?.text = recipe.title
        return cell
    }
}

extension UIView {
    func pinDescriptionView(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}


//
//tableView.translatesAutoresizingMaskIntoConstraints = false
//tableView.topAnchor.constraint(equalTo: image.bottomAnchor).isActive = true
//tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

