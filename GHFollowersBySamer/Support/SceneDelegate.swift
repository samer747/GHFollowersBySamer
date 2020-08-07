//
//  SceneDelegate.swift
//  GHFollowersBySamer
//
//  Created by samer on 7/27/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        
        
        window?.rootViewController = creatTapBarController()
        
        configeNavigationBar()
    }
    
    func creatSearchNavController() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search" //el kelma ely t7t el sora fe el tabBar
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0) // el sora w el tag da mkan el sora fe el tab bar
        return UINavigationController(rootViewController: searchVC)
    }
    
    func creatFavoriteNavController() -> UINavigationController {
        let favoriteVC = FavoriteVC()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        return UINavigationController(rootViewController: favoriteVC)
    }
    
    func creatTapBarController() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen // da loon el zorar ely metdas 3lih 7alynnn
        tabbar.viewControllers = [creatSearchNavController(),creatFavoriteNavController()]
        return tabbar
    }
    func configeNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

