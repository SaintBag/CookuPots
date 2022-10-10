//
//  CategoriesVC.swift
//  CookuPots
//
//  Created by Sebulla on 23/03/2022.
//

import UIKit
import Kingfisher

final class CategoriesVC: UICollectionViewController {
    typealias Dependencies = HasAPIClient
    
    struct Category {
        let image: UIImage
        let title: String
    }
    
    private let dependencies: Dependencies
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    
    private let categories: [Category] = [
        .init(image: UIImage(#imageLiteral(resourceName: "breakfast")), title: "BREAKFAST"),
        .init(image: UIImage(#imageLiteral(resourceName: "dinner")), title: "DINNER"),
        .init(image: UIImage(#imageLiteral(resourceName: "soup")), title: "SOUPS"),
        .init(image: UIImage(#imageLiteral(resourceName: "desserts")), title: "DESSERTS"),
    ]
    
    private static let categoryHeaderId = "categoryHeaderId"
    private let headerId = "headerId"
    private let collectionCellId = "CollectionCellId"
    
    var randomRecipes: [RandomRecipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadSections(IndexSet([1]))
            }
        }
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(collectionViewLayout: CategoriesVC.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.bottom
        titleLogoSetup()
        setupCollectionView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    private func titleLogoSetup() {
        let navController = navigationController!
        
        let image = UIImage(named: "CookUPots")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width / 2
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 5
        let bannerY = bannerHeight / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .white
        navigationItem.titleView = imageView
    }
    
    private func loadData() {
        dependencies.apiClient.downloadRandomRecipies { (recipes, error) in
            if let error = error {
                let alert = UIAlertController(title: "Sorry something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            self.randomRecipes = recipes
        }
    }
    
    private func setupCollectionView() {
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: collectionCellId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: Self.categoryHeaderId, withReuseIdentifier: headerId)
    }
    
    private static func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(150)))
                item.contentInsets.leading = 1.25
                item.contentInsets.trailing = 1.25
                item.contentInsets.bottom = 1.25
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                group.contentInsets.leading = 8
                group.contentInsets.trailing = 8
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 5
                section.contentInsets.bottom = 5
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .topLeading)
                ]
                return section
                
            } else if sectionNumber == 1 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 5
                item.contentInsets.bottom = 16
                item.contentInsets.leading = 5
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [item])
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 5
                section.contentInsets.bottom = 5
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .topLeading)
                ]
                section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                    items.forEach { item in
                        let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                        let minScale: CGFloat = 0.5
                        let maxScale: CGFloat = 1.0
                        let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                        item.transform = CGAffineTransform(scaleX: scale, y: scale)
                    }
                }
                return section
                
            }
            return nil
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let vc = RecipeListVC(dependencies: dependencies, foodType: .breakfast)
                vc.title = "BREAKFAST"
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if indexPath.row == 1 {
                let vc = RecipeListVC(dependencies: dependencies, foodType: .mainCourse)
                vc.title = "DINNER"
                navigationController?.pushViewController(vc, animated: true)
                
            } else if indexPath.row == 2 {
                let vc = RecipeListVC(dependencies: dependencies, foodType: .soup)
                navigationController?.pushViewController(vc, animated: true)
                vc.title = "SOUP"
                
            } else {
                let vc = RecipeListVC(dependencies: dependencies, foodType: .dessert)
                navigationController?.pushViewController(vc, animated: true)
                vc.title = "DESSERT"
            }
            
        } else if indexPath.section == 1 {
            let recipe = randomRecipes[indexPath.row]
            let vc = FoodController(dependencies: dependencies as! AllDependencies, recipe: recipe, instructions: recipe.analyzedInstructions.first?.steps)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return categories.count
        } else if section == 1 {
            return randomRecipes.count
        }
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? Header {
            if indexPath.section == 0 {
                header.setTitle(title: "Check The Categories")
            } else if indexPath.section == 1 {
                header.setTitle(title: "Get Inspired To Try Something New")
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId , for: indexPath) as! CategoriesCell
        
        if indexPath.section == 0 {
            cell.categoryImageView.image = categories[indexPath.row].image
            cell.setCategoriesNameLabel(title: categories[indexPath.row].title)
        } else if indexPath.section == 1 {
            let randomRecipe = self.randomRecipes[indexPath.row]
            cell.setCategoriesNameLabel(title: randomRecipe.title.uppercased())
            let url = URL(string: randomRecipe.image)!
            cell.categoryImageView.kf.setImage(with: url)
        }
        return cell
    }
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItem indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 200)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 1
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
}
