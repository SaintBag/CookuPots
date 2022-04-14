//
//  CategoriesVC.swift
//  CookuPots
//
//  Created by Sebulla on 23/03/2022.
//

import UIKit
import Kingfisher

struct CustomData {
    var image: UIImage
}

class CategoriesVC: UICollectionViewController {
    
    let data = [
        CustomData.init(image: #imageLiteral(resourceName: "breakfast")),
        CustomData.init(image: #imageLiteral(resourceName: "dinner")),
        CustomData.init(image: #imageLiteral(resourceName: "soup")),
        CustomData.init(image: #imageLiteral(resourceName: "desserts"))
    ]
    
    let apiClient: APIClient
    let searchBar = UISearchBar()
    static let categoryHeaderId = "categoryHeaderId"
    let headerId = "headerId"
    let CollectionCellId = "CollectionCellId"
    
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(collectionViewLayout: CategoriesVC.createLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        collectionView.backgroundColor = .white
        
        navigationItem.title = "Cook U Pots"
        // TODO: how to make large title or customize title
        
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CollectionCellId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: CategoriesVC.categoryHeaderId, withReuseIdentifier: headerId)
        
    }
    
    private static func createLayout() -> UICollectionViewCompositionalLayout {
        
        return  UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(150)))
                
                item.contentInsets.top = 2.5
                item.contentInsets.trailing = 2.5

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 5
                section.contentInsets.leading = 8
                section.contentInsets.trailing = 8
                section.contentInsets.bottom = 5
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .topLeading)
                ]
                return section
                
            } else if sectionNumber == 1 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 16
                item.contentInsets.leading = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 5
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .topLeading)
                    
                ]
                return section
                
            }
            return nil
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let vc = RecipeListVC(apiClient: apiClient, foodType: .breakfast)
                vc.title = "BREAKFAST"
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if indexPath.row == 1 {
                let vc = RecipeListVC(apiClient: apiClient, foodType: .mainCourse)
                vc.title = "DINNER"
                navigationController?.pushViewController(vc, animated: true)
                
            } else if indexPath.row == 2 {
                let vc = RecipeListVC(apiClient: apiClient, foodType: .soup)
                navigationController?.pushViewController(vc, animated: true)
                vc.title = "SOUP"
                
            } else {
                let vc = RecipeListVC(apiClient: apiClient, foodType: .dessert)
                navigationController?.pushViewController(vc, animated: true)
                vc.title = "DESSERT"
            }
            //TODO: Recommended
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return data.count
        }
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? Header {
            header.backgroundColor = #colorLiteral(red: 0.9403709769, green: 0.4984640479, blue: 0.6089645624, alpha: 1)
            if indexPath.section == 0 {
                header.setTitle(title: "CATEGORIES")
            } else if indexPath.section == 1 {
                header.setTitle(title: "RECOMMENDED")
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellId , for: indexPath) as! CategoriesCell
        cell.data = self.data[indexPath.row]
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.setCategoriesNameLabel(title: "BREAKFAST")
            } else if indexPath.row == 1 {
                cell.setCategoriesNameLabel(title: "DINNER")
            } else if indexPath.row == 2 {
                cell.setCategoriesNameLabel(title: "SOUPS")
            } else if indexPath.row == 3 {
                cell.setCategoriesNameLabel(title: "DESSERTS")
                
            } else if indexPath.section == 1 {
                if indexPath.row == 0 {
                    
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItem indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 200)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -  SEARCH BAR ADDED TO CategoriesVC

extension CategoriesVC {
    
    func configureUI() {
        view.backgroundColor = .white
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .red
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        
        searchBarSetup()
        showSearchBarButton(schouldShow: true)
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
    
    @objc func handleShowSearch() {
        search(schouldShow: true)
        searchBar.becomeFirstResponder()
        
    }
    
    func showSearchBarButton(schouldShow: Bool) {
        if schouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "magnifyingglass"),
                style: .plain,
                target: self,
                action: #selector(handleShowSearch))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(schouldShow: Bool) {
        showSearchBarButton(schouldShow: !schouldShow)
        searchBar.showsCancelButton = schouldShow
        searchBar.showsSearchResultsButton = schouldShow
        navigationItem.titleView = schouldShow ? searchBar : nil
    }
}

extension CategoriesVC: UISearchBarDelegate {
    
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
}
