//
//  RecipeDescriptionVC.swift
//  CookuPots
//
//  Created by Sebulla on 29/03/2022.
//

import UIKit

// as a table view
// recipe image at the top of view
// title under image
// ingredients with option to add it to shopping list
// directions

class RecipeDescriptionVC: UIViewController {
    private let recipe: Recipe
    private lazy var tableView = UITableView()
    // TODO: Init with recipe
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
