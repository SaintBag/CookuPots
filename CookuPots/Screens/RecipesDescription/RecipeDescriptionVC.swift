//
//  RecipeDescriptionVC.swift
//  CookuPots
//
//  Created by Sebulla on 29/03/2022.
//

import UIKit
import Kingfisher

class RecipeDescriptionVC: UIViewController {
 
    private let recipe: Recipe
    private lazy var tableView = UITableView()
    struct CellID {
        static let ImageCell = "ImageCell"
        static let IngredientsCell = "IngredientsCell"
        static let DirectionsCell = "DirectionsCell"
    }
    
    let imageTableView: UITableView = {
        let tV = UITableView()
        tV.tag = 1
        tV.translatesAutoresizingMaskIntoConstraints = false
        return tV
    }()
    
    let ingredientsTableView: UITableView = {
        let tV = UITableView()
        tV.tag = 2
        tV.translatesAutoresizingMaskIntoConstraints = false
        return tV
    }()
    
    let directionsTableView: UITableView = {
        let tV = UITableView()
        tV.tag = 3
        tV.translatesAutoresizingMaskIntoConstraints = false
        return tV
    }()
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setupTableViewsDelegates()
        setupImageTableView()
        setupIngredientsTableView()
        setupDirectionsTableView()
        
    }
    
    func addSubViews() {
        
        view.addSubview(imageTableView)
        view.addSubview(ingredientsTableView)
        view.addSubview(directionsTableView)
    }
    
    func setupTableViewsDelegates() {
        
        imageTableView.delegate = self
        imageTableView.dataSource = self
        imageTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID.ImageCell)
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID.IngredientsCell)
        
        directionsTableView.delegate = self
        directionsTableView.dataSource = self
        directionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID.DirectionsCell)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

    extension RecipeDescriptionVC: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return 1
        } else if tableView.tag == 2 {
            return 1 // TODO: put later the value of ingredients from decoded api struct
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
            
            tableView.rowHeight = 300
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellID.ImageCell)! as UITableViewCell // TODO: Connect with custom cell
            let url = URL(string: recipe.image)
            cell.imageView?.kf.setImage(with: url)
            
            return cell
            
        } else if tableView.tag == 2 {
            
            tableView.rowHeight = 30.0
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellID.IngredientsCell)! as UITableViewCell // TODO: Connect with custom cell
            cell.textLabel?.text = recipe.title
            
            return cell
        } else {
            tableView.rowHeight = 50.0
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellID.DirectionsCell)! as
            UITableViewCell // TODO: Connect with custom cell
            cell.textLabel?.text = "here you will find the directions for recipe"
            return cell
        }
    }
}

extension RecipeDescriptionVC {
    
    
    func setupImageTableView() {
        
        imageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupIngredientsTableView() {
       
        ingredientsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ingredientsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        ingredientsTableView.topAnchor.constraint(equalTo: imageTableView.bottomAnchor, constant: 100).isActive = true
        ingredientsTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupDirectionsTableView() {
        
        directionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        directionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        directionsTableView.topAnchor.constraint(equalTo: ingredientsTableView.bottomAnchor, constant: 100).isActive = true
        directionsTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
}

