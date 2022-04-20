//
//  SceneDelegate.swift
//  CookuPots
//
//  Created by Sebulla on 23/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dataController = appDelegate.dataController
        dataController.initalizeStack {
            
        }
        let navController = UINavigationController(rootViewController: createTabBar())
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func createHomeNavigationController() -> UINavigationController {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let apiClient = appDelegate.apiClient
        let homeVC = CategoriesVC(apiClient: apiClient)
//        homeVC.title = "Home"
        let houseSymbol = UIImage(systemName: "house")
        homeVC.tabBarItem = UITabBarItem(title: "BACK TO CATEGORIES", image: houseSymbol, tag: 0)
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithOpaqueBackground()
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.backgroundColor = .red
        
        return UINavigationController(rootViewController: homeVC)
    }
    
//    func createFavoritesNavigationController() -> UINavigationController {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let apiClient = appDelegate.apiClient
//        let favoritesVC = FavoritesVC(apiClient: apiClient)
////        favoritesVC.title = "FAVORITES"
//        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//        return UINavigationController(rootViewController: favoritesVC)
//    }
    
    func createShopingListVCNavigationController() -> UINavigationController {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dataController = appDelegate.dataController
        let shoppingVC = ShoppingListVC(dataController: dataController)
//        shoppingVC.title = "Shopping List"
        let cartSymbol = UIImage(systemName: "cart")
        shoppingVC.tabBarItem = UITabBarItem(title: "Shopping List", image: cartSymbol, tag: 1)
        return UINavigationController(rootViewController: shoppingVC)
    }
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
//        UITabBar.appearance().tintColor = .systemGreen
        tabBar.viewControllers = [createHomeNavigationController(),createShopingListVCNavigationController()]
        return tabBar
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

