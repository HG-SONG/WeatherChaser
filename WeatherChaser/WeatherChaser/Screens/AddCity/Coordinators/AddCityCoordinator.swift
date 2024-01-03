//
//  AddCityCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import UIKit

class AddCityCoordinator : Coordinator {
    private var presenter: UINavigationController
    private var addCityViewController = AddCityViewController(nibName: nil, bundle: nil)
    
    init(presenter:UINavigationController) {
        self.presenter = presenter
    }
    
    func changeViewController() {
        self.addCityViewController.title = "Add City"
        self.addCityViewController.delegate = self
        presenter.pushViewController(self.addCityViewController, animated: true)
    }
}

extension AddCityCoordinator: SaveDelegate {
    func saveButtonTouched() {
        self.presenter.popViewController(animated: true)
    }
}
