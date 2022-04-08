//
//  FoodController.swift
//  CookuPots
//
//  Created by Sebulla on 04/04/2022.
//

import UIKit
import Kingfisher

class FoodController: UICollectionViewController {
    
    private let apiClient: APIClient
    private let recipe: Recipe
    private var allIngredients: [Ingredient] = []
    private var instructions: [Step] = [] {
        didSet {
            for instruction in instructions {
                allIngredients.append(contentsOf: instruction.ingredients)
            }
            collectionView.reloadData()
        }
    }
    
    private let IngredientsCellId = "IngredientsCellId"
    private let ImageCellId = "ImageCellId"
    private let RecipeInstructionCellId = "RecipeInstructionCellId"
    private let sectionHeaderId = "sectionHeaderId"
    private let sectionId = "sectionId"
    private let stepsId = "stepsId"
    private let stepsHeaderId = "stepsHeaderId"
    
    private let stepsCell = "stepsCell"
    private let ingCell = "ingCell"
    
    
    init(recipe: Recipe, apiClient: APIClient) {
        self.recipe = recipe
        self.apiClient = apiClient
        super.init(collectionViewLayout: FoodController.createViewLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        registerCells()
        apiClient.downloadInstructions(forRecipeID: recipe.id) { [weak self] (instructions, error) in
            self?.instructions = instructions
            
        }
    }
    func registerCells() {
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

                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)) )
                
                item.contentInsets.top = 5
                item.contentInsets.trailing = 2.5
                item.contentInsets.leading = 2.5
                
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.contentInsets.leading = 8
                section.contentInsets.trailing = 8
                section.contentInsets.leading = 8
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), elementKind: sectionHeaderId, alignment: .topLeading)
                ]
                
                return section
                
            } else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 16
                item.contentInsets.leading = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: stepsHeaderId, alignment: .topLeading)
                ]
                return section
            }
            return nil
        }
    }
    //TODO: something wrong with reciving data from ingredients
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 6 //allIngredients.count
        } else if section == 1 {
            return instructions.count
        } else { //if section == 2 {
            return 2
        }
        //        return 3
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionId, for: indexPath) as? IngredientsHeader {
                
                let url = URL(string: recipe.image)
                header.recipePhoto.kf.setImage(with: url)
                header.backgroundColor = #colorLiteral(red: 0.9403709769, green: 0.4984640479, blue: 0.6089645624, alpha: 1)
                header.imageTitleLabel.text = recipe.title.uppercased()
                header.ingredientsLabel.text = "INGREDIENTS"
                
                return header
            }
            
        } else if indexPath.section == 1 {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: stepsId, for: indexPath) as? StepsHeader {
                
                header.backgroundColor = #colorLiteral(red: 0.9403709769, green: 0.4984640479, blue: 0.6089645624, alpha: 1)
                header.setTitle(title: "RECIPE STEPS")
                return header
            }
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ingCell, for: indexPath) as? IngCell else { return UICollectionViewCell() }
            // TODO: - error
            //            print(allIngredients[indexPath.row].name)
//                        cell.ingredients = ingredients
            cell.label.text = "allIngredients[indexPath.row].name"
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepsCell , for: indexPath) as? StepsCell else { return UICollectionViewCell() }
            
            cell.contentView.isUserInteractionEnabled = false
            cell.instructions = instructions
            let stepNumber = instructions[indexPath.row].number
            cell.setTitle(title: "STEP: \(stepNumber)")
            let recipeText = instructions[indexPath.row].step
            cell.label.text = recipeText
            return cell
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

