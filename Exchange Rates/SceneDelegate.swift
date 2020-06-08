//
//  SceneDelegate.swift
//  Exchange Rates
//
//  Created by Roman Matusewicz on 25/05/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
            guard let scene = scene as? UIWindowScene else { return }
            window = UIWindow(windowScene: scene)
            window?.rootViewController = UINavigationController(rootViewController: RatesController())//RatesController()
            window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}

