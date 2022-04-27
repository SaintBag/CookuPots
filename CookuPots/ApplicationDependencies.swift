//
//  AppDependencies.swift
//  CookuPots
//
//  Created by Kamil Chołyk on 27/04/2022.
//

import UIKit

typealias AllDependencies = HasAPIClient & HasDataController

final class ApplicationDependencies: AllDependencies {
    lazy var rootViewController: UIViewController = createTabBar()
    lazy var apiClient: APIClientProtocol = APIClient()
    lazy var dataController: DataControllerProtocol = DataController()

    private func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = .purple
        tabBar.tabBar.unselectedItemTintColor = .white
        tabBar.tabBar.barTintColor = .systemPurple
        tabBar.viewControllers = [createHomeNavigationController(),
                                  createShopingListVCNavigationController()]
        return tabBar
    }
    
    private func createHomeNavigationController() -> UINavigationController {
        let homeVC = CategoriesVC(dependencies: self)
        let houseSymbol = UIImage(systemName: "house")
        homeVC.tabBarItem = UITabBarItem(title: "BACK TO CATEGORIES", image: houseSymbol, tag: 0)
        return UINavigationController(rootViewController: homeVC)
    }
        
    private func createShopingListVCNavigationController() -> UINavigationController {
        let shoppingVC = ShoppingListVC(dependencies: self)
        let cartSymbol = UIImage(systemName: "cart")
        shoppingVC.tabBarItem = UITabBarItem(title: "Shopping List", image: cartSymbol, tag: 1)
        return UINavigationController(rootViewController: shoppingVC)
    }
}
