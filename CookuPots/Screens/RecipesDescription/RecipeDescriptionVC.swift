//
//  RecipeDescriptionVC.swift
//  CookuPots
//
//  Created by Sebulla on 29/03/2022.
//

import UIKit
import Kingfisher

class RecipeDescriptionVC: UIViewController {
    
    private let apiClient: APIClient
    private let recipe: Recipe
    let recipeID: Int
    private lazy var tableView = UITableView()
    struct CellID {
        static let IngredientsCell = "IngredientsCell"
        static let DirectionsCell = "DirectionsCell"
    }
    private var instructions: [Step] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    
    let imageView: UIImageView = {
        let tV = UIImageView()
        tV.tag = 1
        tV.contentMode = .scaleAspectFill
        tV.translatesAutoresizingMaskIntoConstraints = false
        return tV
    }()
    
    let ingredientsTableView: UITableView = {
        let tV = UITableView()
        tV.tag = 2
        tV.translatesAutoresizingMaskIntoConstraints = false
        return tV
    }()
    
    let directionsLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Heat 1T butter and 1T oil in a large skillet over medium heat. Then add cold rice (it separates easily, so it won't clump up during cooking), plus the additional grapeseed and coconut oil or butter. Raise heat to medium-high. Toss everything together and, again, spread the mixture out over the whole pan and press a bit into the bottom."
        textLabel.textAlignment = .left
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        textLabel.backgroundColor = .white
        textLabel.tag = 3
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    init(recipe: Recipe, apiClient: APIClient, recipeID: Int ) {
        self.recipe = recipe
        self.apiClient = apiClient
        self.recipeID = recipe.id
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubViews()
        setupTableViewsDelegates()
        setupImageView()
        setupIngredientsTableView()
        setupDirectionsTableView()
        getInstructions()
        addPhotoUrl()
        apiClient.downloadInstructions(forRecipeID: recipe.id) { [weak self] (instructions, error) in
            self?.instructions = instructions
          print(instructions)
        }
    }
    func addPhotoUrl() {
        let url = URL(string: recipe.image)
        imageView.kf.setImage(with: url)
    }
    
    
    func getInstructions() {
        // TODO: Use apiClient new func
        
    }
    
    func addSubViews() {
        
        view.addSubview(imageView)
        view.addSubview(ingredientsTableView)
        view.addSubview(directionsLabel)
    }
    
    func setupTableViewsDelegates() {
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID.IngredientsCell)
        
//        directionsTableView.delegate = self
//        directionsTableView.dataSource = self
//        directionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID.DirectionsCell)
        
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
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
            
            tableView.rowHeight = 200
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
           
            
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
            cell.textLabel?.text = instructions[indexPath.row].step
            return cell
        }
    }
}

extension RecipeDescriptionVC {
    
   
    
    func setupImageView() {
    
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupIngredientsTableView() {
        
        ingredientsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ingredientsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        ingredientsTableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50).isActive = true
        ingredientsTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupDirectionsTableView() {
        
        directionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        directionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        directionsLabel.topAnchor.constraint(equalTo: ingredientsTableView.bottomAnchor, constant: 50).isActive = true
        directionsLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
}

