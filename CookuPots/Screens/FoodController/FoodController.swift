//
//  FoodController.swift
//  CookuPots
//
//  Created by Sebulla on 04/04/2022.
//

import UIKit
import Kingfisher

protocol RecipePresentable {
    var id: Int { get }
    var title: String { get }
    var image: String { get }
}

extension Recipe: RecipePresentable {}
extension RandomRecipe: RecipePresentable {}

final class FoodController: UICollectionViewController {
    typealias Dependencies = HasAPIClient & HasDataController
    
    private let dependencies: Dependencies
    private let recipe: RecipePresentable

    private var allIngredients: [Ingredient] = []
    private var instructions: [Step] = [] {
        didSet {
            allIngredients.removeAll()
            var duplicatedIngredients: [Ingredient] = []
            for instruction in instructions {
                duplicatedIngredients.append(contentsOf: instruction.ingredients)
            }
            let set = Set(duplicatedIngredients)
            let ingredientsWithoutDuplicates = Array(set)
            allIngredients = ingredientsWithoutDuplicates
            collectionView.reloadData()
        }
    }
    
    private let sectionHeaderId = "sectionHeaderId"
    private let sectionId = "sectionId"
    private let stepsId = "stepsId"
    private let stepsHeaderId = "stepsHeaderId"
    private let stepsCell = "stepsCell"
    private let ingCell = "ingCell"
    
    init(dependencies: Dependencies, recipe: RecipePresentable, instructions: [Step]?) {
        self.dependencies = dependencies
        self.recipe = recipe
        super.init(collectionViewLayout: FoodController.createViewLayout())
        DispatchQueue.main.async {
            self.instructions = instructions ?? []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerCells()
        downloadInstructions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func downloadInstructions() {
        if instructions.isEmpty {
            dependencies.apiClient.downloadInstructions(forRecipeID: recipe.id) { [weak self] (instructions, error) in
                self?.instructions = instructions
            }
        }
    }
    
    private func registerCells() {
        collectionView.register(IngCell.self, forCellWithReuseIdentifier: ingCell)
        collectionView.register(StepsCell.self, forCellWithReuseIdentifier: stepsCell)
        collectionView.register(IngredientsHeader.self, forSupplementaryViewOfKind: self.sectionHeaderId , withReuseIdentifier: sectionId)
        collectionView.register(StepsHeader.self, forSupplementaryViewOfKind: self.stepsHeaderId , withReuseIdentifier: stepsId)
    }
    
    private static func createViewLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            let sectionHeaderId = "sectionHeaderId"
            let stepsHeaderId = "stepsHeaderId"
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)))
                
                item.contentInsets.top = 5
                item.contentInsets.trailing = 2.5
                item.contentInsets.leading = 2.5
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 8, bottom: 20, trailing: 8)
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), elementKind: sectionHeaderId, alignment: .topLeading)
                ]
                
                return section
                
            } else if sectionNumber == 1 {
                
                let estimatedHeight = CGFloat(100)
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight))
                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.interGroupSpacing = 10
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: stepsHeaderId, alignment: .topLeading)
                ]
                return section
            }
            return nil
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return  allIngredients.count
        } else if section == 1 {
            return instructions.count
        } else {
            return 2
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionId, for: indexPath) as? IngredientsHeader {
                
                let url = URL(string: recipe.image)
                header.recipePhoto.kf.setImage(with: url)
                
                let imageTitleLabel = recipe.title.uppercased()
                header.setImageTitleLabel(title: imageTitleLabel)
                header.setTitle(title: "INGREDIENTS")
                return header
            }
            
        } else if indexPath.section == 1 {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: stepsId, for: indexPath) as? StepsHeader {
                
                header.setTitle(title: "RECIPE STEPS")
                return header
            }
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ingCell, for: indexPath) as? IngCell else { return UICollectionViewCell() }
            
            let ingredient = allIngredients[indexPath.row]
            cell.setIngredientLabel(text: ingredient.name.capitalized)
            let isAlreadyInBasket = dependencies.dataController.isSaved(ingredient: ingredient)
            cell.setButtonState(isSelected: isAlreadyInBasket)
            cell.addToCartAction = { [weak self] shouldDelete in
                do {
                    if shouldDelete {
                        try self?.dependencies.dataController.delete(ingredient: ingredient)
                    } else {
                        try self?.dependencies.dataController.insertIngredient(ingredient: ingredient)
                    }
                } catch(let error) {
                    print(error)
                }
            }
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepsCell , for: indexPath) as? StepsCell else { return UICollectionViewCell() }
            
            let stepNumber = instructions[indexPath.row].number
            let recipeText = instructions[indexPath.row].step 
            
            cell.setTitle(title: "STEP: \(stepNumber)")
            cell.setRecipeText(text: recipeText)
            cell.sizeToFit()
            return cell
        }
    }
}

extension FoodController {
    
    func configureUI() {
        collectionView.backgroundColor = .white
        rightBarButtonSetup()
    }
    
    private func rightBarButtonSetup() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shopping List", style: .plain, target: self, action: #selector(moveToShoppingList))
    }
    
    @objc func moveToShoppingList() {
        let vc = ShoppingListVC(dependencies: dependencies)
        navigationController?.pushViewController(vc, animated: true)
    }
}
