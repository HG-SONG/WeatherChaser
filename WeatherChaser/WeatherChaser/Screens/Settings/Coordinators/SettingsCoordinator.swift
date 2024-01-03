//
//  SettingsCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import UIKit

class SettingsCoordinator: Coordinator {
    private var presenter: UINavigationController
    private let settingsTableViewController = SettingsTableViewController(nibName: nil, bundle: nil)
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func changeViewController() {
        self.settingsTableViewController.title = "Settings"
        self.settingsTableViewController.delegate = self
        self.presenter.pushViewController(self.settingsTableViewController, animated: true)
    }
    
}

extension SettingsCoordinator: SaveDelegate {
    func saveButtonTouched() {
        self.presenter.popViewController(animated: true)
    }
}
