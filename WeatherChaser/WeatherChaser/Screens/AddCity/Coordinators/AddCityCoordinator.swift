//
//  AddCityCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import UIKit

class AddCityCoordinator : Coordinator {
    private var presenter: UINavigationController
    private var addCityViewController : AddCityViewController?
    
    init(presenter:UINavigationController) {
        self.presenter = presenter
    }
    
    func changeViewController() {
        let addCityViewController = AddCityViewController(nibName: nil, bundle: nil)
        addCityViewController.title = "Add City"
        addCityViewController.delegate = self
        self.addCityViewController = addCityViewController
        presenter.pushViewController(addCityViewController, animated: true)
    }
}

extension AddCityCoordinator: AddCityDelegate {
    func saveButtonTouched() {
        presenter.popViewController(animated: true)
    }
}
