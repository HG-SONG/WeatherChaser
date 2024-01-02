//
//  SceneDelegate.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let coordinator = RootCoordinator(window)
        coordinator.changeViewController()
        self.window = window
    }
}

