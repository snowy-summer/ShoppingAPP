//
//  TabBarController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .point
        tabBar.unselectedItemTintColor = .subtitle
        
        let mainViewController = MainViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.tabBarItem = UITabBarItem(title: "검색",
                                                           image: UIImage(systemName: IconType.searchTabBarIcon.iconString),
                                                           tag: 0)
        
        let likeViewController = LikeListViewController()
        let likeNavigationController = UINavigationController(rootViewController: likeViewController)
        likeNavigationController.tabBarItem = UITabBarItem(title: "좋아요",
                                                              image: UIImage(systemName: IconType.settingTabBarIcon.iconString),
                                                              tag: 1)
        
        let settingViewController = SettingViewController()
        let settingNavigationController = UINavigationController(rootViewController: settingViewController)
        settingNavigationController.tabBarItem = UITabBarItem(title: "설정",
                                                              image: UIImage(systemName: IconType.settingTabBarIcon.iconString),
                                                              tag: 2)
        
        setViewControllers([mainNavigationController,likeNavigationController, settingNavigationController],
                           animated: false)
    }
}
