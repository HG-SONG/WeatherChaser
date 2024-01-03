//
//  WeatherListViewControllerCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/03.
//

import UIKit

class WeatherListCoordinator: Coordinator {
    private var presenter : UINavigationController
    private let weatherListTableViewController = WeatherListTableViewController(style: .grouped)
    private let addCityCoordinator : AddCityCoordinator
    private let settingsCoordinator : SettingsCoordinator
    private let weatherDetailCoordinator : WeatherDetailCoordinator
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.addCityCoordinator = AddCityCoordinator(presenter: presenter)
        self.settingsCoordinator = SettingsCoordinator(presenter: presenter)
        self.weatherDetailCoordinator = WeatherDetailCoordinator(presenter: presenter)
    }
    
    func changeViewController() {
        self.weatherListTableViewController.title = "Weather List"
        self.weatherListTableViewController.delegate = self
        self.presenter.pushViewController(weatherListTableViewController, animated: true)
    }
    
    func changeViewController(with something: Any) {
        guard let viewModel = something as? WeatherCellViewModel else {
            return
        }
        self.weatherListTableViewController.title = "Weather List"
        self.weatherListTableViewController.delegate = self
        
        self.weatherListTableViewController.addCity(cellViewModel: viewModel)
        self.presenter.pushViewController(weatherListTableViewController, animated: true)
    }
}

extension WeatherListCoordinator : CoordinatorDelegate {
    func addCityButtonTouched() {
        self.addCityCoordinator.changeViewController()
    }
    
    func settingsButtonTouched() {
        self.settingsCoordinator.changeViewController()
    }
    
    func weatherCellTouched(at indexPath: IndexPath) {
        self.weatherDetailCoordinator.changeViewController(with: indexPath)
    }
}
