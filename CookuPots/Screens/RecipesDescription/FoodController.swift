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
    
    private lazy var tableView = UITableView()
    private var instructions: [Step] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let IngredientsCellId = "IngredientsCellId"
    private let ImageCellId = "ImageCellId"
    private let RecipeInstructionCellId = "RecipeInstructionCellId"
    private let sectionHeaderId = "sectionHeaderId"
    private let sectionId = "sectionId"
    
    
    
    init(recipe: Recipe, apiClient: APIClient) {
        self.recipe = recipe
        self.apiClient = apiClient
        
        super.init(collectionViewLayout: FoodController.createViewLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCellId)
        collectionView.register(IngredientsViewCell.self, forCellWithReuseIdentifier: IngredientsCellId)
        collectionView.register(RecipeInstructionCell.self, forCellWithReuseIdentifier: RecipeInstructionCellId)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: self.sectionHeaderId , withReuseIdentifier: sectionId)
        
        apiClient.downloadInstructions(forRecipeID: recipe.id) { [weak self] (instructions, error) in
            self?.instructions = instructions
            
            
        }
    }
    
    private static func createViewLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            let sectionHeaderId = "sectionHeaderId"
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 16
                item.contentInsets.leading = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                
                return section
                
            } else if sectionNumber == 1 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 16
                item.contentInsets.leading = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: sectionHeaderId, alignment: .topLeading)
                ]
                
                return section
                
            } else if sectionNumber == 2 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.5)))
                
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 16
                item.contentInsets.leading = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: sectionHeaderId, alignment: .topLeading)
                ]
                
                return section
                
            } else if sectionNumber == 3 {
//                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//
//                item.contentInsets.trailing = 8
//                item.contentInsets.bottom = 16
//                item.contentInsets.leading = 8
//
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), subitems: [item])
//
//                let section = NSCollectionLayoutSection(group: group)
//
//
//
//                return section
            }
            return nil
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionId, for: indexPath) as? SectionHeader {
            header.backgroundColor = .white
            if indexPath.section == 1 {
                header.setTitle(title: "INGREDIENTS")
            } else if indexPath.section == 2 {
                header.setTitle(title: "RECIPE")
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        }
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellId, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
//            guard let cell = cell else { return UICollectionViewCell() }
            cell.backgroundColor = .yellow
            
//            let photo = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
            let url = URL(string: recipe.image)
            cell.recipePhoto.kf.setImage(with: url)
//            cell.contentView.addSubview(photo)
            let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 50))
            title.text = recipe.title
            title.font = UIFont(name: "Papyrus", size: 15)
            title.textAlignment = .center
            title.backgroundColor = .init(red: 105/105, green: 105/105, blue: 105/105, alpha: 0.8)
            cell.contentView.addSubview(title)
            
            return cell
            
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCellId , for: indexPath)
            cell.backgroundColor = .red
            return cell
            
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeInstructionCellId, for: indexPath) as? RecipeInstructionCell
            cell?.backgroundColor = .gray
            cell?.isHighlighted = true
            cell?.instructions = instructions
            return cell ?? UICollectionViewCell()
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath)
            cell.backgroundColor = .gray
            cell.isHighlighted = true
            return cell
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - SectionHeader

class SectionHeader: UICollectionReusableView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        label.textAlignment = .left
        label.backgroundColor = .init(red: 105/105, green: 105/105, blue: 105/105, alpha: 0.8)
        label.font = UIFont(name: "Papyrus", size: 30)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String) {
        label.text = title
    }
}
