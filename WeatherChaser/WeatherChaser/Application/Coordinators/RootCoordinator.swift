//
//  RootViewControllerCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/03.
//

import UIKit

class RootCoordinator : Coordinator {
    private var window : UIWindow?
    private let rootViewController: UINavigationController
    private let weatherListCoordinator : WeatherListCoordinator
    
    init(_ window: UIWindow) {
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.prefersLargeTitles = true
        
        self.window = window
        self.weatherListCoordinator = WeatherListCoordinator(presenter: rootViewController)
    }
    
    func changeViewController() {
        APIKeyFetcher.fetchAPIKey { result in
            switch result {
            case .success(_) :
                self.window?.rootViewController = self.rootViewController
                self.window?.makeKeyAndVisible()
                self.weatherListCoordinator.changeViewController()
            case .failure(_) :
                DispatchQueue.main.async {
                    self.window?.rootViewController = self.rootViewController
                    self.window?.makeKeyAndVisible()
                    ErrorCoordinator(presenter: self.rootViewController).changeViewController()
                }
            }
        }
    }
    
}
