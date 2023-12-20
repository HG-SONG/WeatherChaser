//
//  WeatherListViewControllerCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/03.
//

import UIKit

class WeatherListCoordinator: Coordinator {
    private var presenter : UINavigationController
    private var weatherListTableViewController = WeatherListTableViewController(style: .grouped)
    private var addCityCoordinator : AddCityCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func changeViewController() {
        self.weatherListTableViewController.title = "Weather List"
        self.weatherListTableViewController.delegate = self
        self.presenter.pushViewController(weatherListTableViewController, animated: true)
    }
    
    func changeViewController(with viewModel: Any) {
        guard let viewModel = viewModel as? WeatherCellViewModel else {
            return
        }
        self.weatherListTableViewController.title = "Weather List"
        self.weatherListTableViewController.delegate = self
        
        self.weatherListTableViewController.addCity(cellViewModel: viewModel)
        self.presenter.pushViewController(weatherListTableViewController, animated: true)
    }
    
}

extension WeatherListCoordinator : BarButtonActionDelegate {
    func addCityButtonTouched() {
        let addCityCoordinator = AddCityCoordinator(presenter: self.presenter)
        
        addCityCoordinator.changeViewController()
    }
    
    func settingsButtonTouched() {
        let settingsCoordinator = SettingsCoordinator(presenter: self.presenter)
        settingsCoordinator.changeViewController()
    }
}
