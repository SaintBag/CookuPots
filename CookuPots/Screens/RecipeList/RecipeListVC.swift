//
//  RecipeListVC.swift
//  CookuPots
//
//  Created by Sebulla on 28/03/2022.
//

import UIKit
import Kingfisher

class RecipeListVC: UIViewController {
    let searchBar = UISearchBar()
    private lazy var tableView = UITableView()
    private var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
        configureUI()
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
        DispatchQueue.main.async {
            let url = URL(string: recipe.image)
            cell.imageView?.kf.setImage(with: url)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.RecipeCell) as! RecipeCell
        let recipe = recipes[indexPath.row]
        let url = URL(string: recipe.image)
        cell.imageView?.kf.setImage(with: url)
        
        let recipeTitle = recipe.title
        title = recipeTitle
        let id = recipe.id
        let title = recipe.title
        let image = recipe.image
        
        let dataController = (UIApplication.shared.delegate as! AppDelegate).dataController
        let vc = FoodController(recipe: Recipe.init(id: id, title: title, image: image), instructions: nil, apiClient: apiClient, dataController: dataController)
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

extension RecipeListVC {
    
    func configureUI() {
        
        searchBarSetup()
        showSearchBarButton(schouldShow: true)
    }
}

extension RecipeListVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar did begin editing...")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("Search bar did end editing..")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is \(searchText)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(schouldShow: false)
    }
    func searchBarSetup() {
        
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        searchBar.tintColor = .black
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        
    }
    
    func showSearchBarButton(schouldShow: Bool) {
        if schouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "magnifyingglass"),
                style: .plain,
                target: self,
                action: #selector(handleShowSearch))
            navigationItem.rightBarButtonItem?.tintColor = .white
            navigationItem.rightBarButtonItem?.width = 20
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func handleShowSearch() {
        search(schouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func search(schouldShow: Bool) {
        showSearchBarButton(schouldShow: !schouldShow)
        searchBar.showsCancelButton = schouldShow
        searchBar.showsSearchResultsButton = schouldShow
        navigationItem.titleView = schouldShow ? searchBar : nil
    }
}
