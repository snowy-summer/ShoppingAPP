//
//  SceneDelegate.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewController: UIViewController
        
        if UserData.data.nickname != nil {
            viewController = TabBarController()
        } else {
            viewController = UINavigationController(rootViewController: OnboardingViewController())
        }
    
//        viewController = UINavigationController(rootViewController: OnboardingViewController())
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }


}

