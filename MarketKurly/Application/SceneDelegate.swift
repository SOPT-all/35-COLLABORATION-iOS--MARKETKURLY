//
//  SceneDelegate.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/17/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        self.window?.rootViewController = TabBarController()
        self.window?.makeKeyAndVisible()
    }
}

