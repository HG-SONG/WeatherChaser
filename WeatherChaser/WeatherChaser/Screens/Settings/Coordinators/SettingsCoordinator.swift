//
//  SettingsCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import UIKit

class SettingsCoordinator: Coordinator {
    private var presenter: UINavigationController
    private var settingsTableViewController : SettingsTableViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    func changeViewController() {
        let settingsTableViewController = SettingsTableViewController(nibName: nil, bundle: nil)
        settingsTableViewController.title = "Settings"
        settingsTableViewController.delegate = self
        self.settingsTableViewController = settingsTableViewController
        self.presenter.pushViewController(settingsTableViewController, animated: true)
    }
    
}

extension SettingsCoordinator: SaveDelegate {
    func saveButtonTouched() {
        presenter.popViewController(animated: true)
    }
}
