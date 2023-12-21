//
//  WeatherDetailCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/21.
//

import UIKit

class WeatherDetailCoordinator: Coordinator {
    private var presenter : UINavigationController
    private var weatherDetailViewController : SettingsTableViewController?
    
    init(presenter : UINavigationController){
        self.presenter = presenter
    }
    
    func changeViewController() {
        let weatherDetailViewController = WeatherDetailViewController(nibName: nil, bundle: nil)
        weatherDetailViewController.title = "View in detail"
        self.presenter.pushViewController(weatherDetailViewController, animated: true)
    }
    
}
