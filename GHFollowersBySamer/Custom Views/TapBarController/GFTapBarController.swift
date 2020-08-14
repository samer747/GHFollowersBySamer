//
//  GFTapBarController.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/13/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFTapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemGreen // da loon el zorar ely metdas 3lih 7alynnn
        viewControllers = [creatSearchNavController(),creatFavoriteNavController()]
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

}
