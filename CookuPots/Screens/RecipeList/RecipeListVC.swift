//
//  RecipeListVC.swift
//  CookuPots
//
//  Created by Sebulla on 28/03/2022.
//

import UIKit
import Kingfisher

class RecipeListVC: UIViewController {
    
    private lazy var tableView = UITableView()
    private var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    struct CellID {
        static let RecipeCell = "RecipeCell"
    }
    private let apiClient: APIClient
    private let foodCategory: FoodCategory
    
    init(apiClient: APIClient, foodType: FoodCategory) {
        self.apiClient = apiClient
        self.foodCategory = foodType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
        apiClient.downloadRecipies(ofType: foodCategory) { [weak self] (recipes, error) in
            self?.recipes = recipes
        }
    }
    func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(RecipeCell.self, forCellReuseIdentifier: CellID.RecipeCell)
        tableView.pinView(to: view)
        
    }
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension RecipeListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.RecipeCell) as! RecipeCell
        
        let recipe = recipes[indexPath.row]
        cell.recipeTitleLabel.text = recipe.title
        
        let url = URL(string: recipe.image)
        cell.imageView?.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.RecipeCell) as! RecipeCell
        let recipe = recipes[indexPath.row]
        let url = URL(string: recipe.image)
        cell.imageView?.kf.setImage(with: url)
        
        let recipeTitle = recipe.title
        title = recipeTitle
        // TODO: not sure about parameters here
        let id = recipe.id
        let title = recipe.title
        let image = recipe.image
        let vc = RecipeDescriptionVC(recipe: Recipe.init(id: id, title: title, image: image), apiClient: apiClient, recipeID: recipe.id)
        self.navigationController?.pushViewController(vc,animated: true)
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
    }
}

extension UIView {
    func pinView(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}


