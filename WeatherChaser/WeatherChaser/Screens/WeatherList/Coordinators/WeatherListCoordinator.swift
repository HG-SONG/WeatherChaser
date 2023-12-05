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
        weatherListTableViewController.title = "WeatherChaser"
        
        self.weatherListTableViewController = weatherListTableViewController
        
        self.presenter.pushViewController(weatherListTableViewController, animated: true)
        
    }
    
}
