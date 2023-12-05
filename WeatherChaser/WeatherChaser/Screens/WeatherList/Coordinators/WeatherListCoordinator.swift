//
//  WeatherListViewControllerCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/03.
//

import UIKit

class WeatherListCoordinator: Coordinator {
    private var presenter : UINavigationController
    private var weatherListTableViewController : WeatherListTableViewController?
    private var addCityCoordinator : AddCityCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func changeViewController() {
        let weatherListTableViewController = WeatherListTableViewController(nibName: nil, bundle: nil)
        weatherListTableViewController.title = "Weather List"
        weatherListTableViewController.delegate = self
        
        self.weatherListTableViewController = weatherListTableViewController
        self.presenter.pushViewController(weatherListTableViewController, animated: true)
        
    }
    
}

extension WeatherListCoordinator : ButtonActionDelegate {
    func addCityButtonTouched() {
        let addCityCoordinator = AddCityCoordinator(presenter: self.presenter)
        addCityCoordinator.changeViewController()
    }
    
    func settingsButtonTouched() {
        let settingsCoordinator = SettingsCoordinator(presenter: self.presenter)
        settingsCoordinator.changeViewController()
    }
}
