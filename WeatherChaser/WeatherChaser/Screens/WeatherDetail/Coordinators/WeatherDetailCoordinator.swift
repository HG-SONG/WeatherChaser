//
//  WeatherDetailCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/21.
//

import UIKit

class WeatherDetailCoordinator: Coordinator {
    private var presenter : UINavigationController
    //private var weatherDetailViewController : WeatherDetailViewController?
    
    init(presenter : UINavigationController){
        self.presenter = presenter
    }
    
    func changeViewController(with something : Any) {
        guard let indexPath = something as? IndexPath else {
            return
        }
        
        guard let previousViewController = self.presenter.topViewController as? WeatherListTableViewController else {
            return
        }
        
        let cellSummary = previousViewController.pullCellData(at: indexPath)
        
        let weatherDetailViewController = WeatherDetailViewController(nibName: nil, bundle: nil)
        weatherDetailViewController.setupViewModel(cellSummary)
        weatherDetailViewController.title = "View in detail"
        
        self.presenter.pushViewController(weatherDetailViewController, animated: true)
    }
    
}
