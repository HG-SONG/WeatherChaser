//
//  AddCityViewController.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import UIKit

class AddCityViewController : UIViewController {
    private var addCityViewModel = AddCityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        test()
    }
    
    private func test() {
        addCityViewModel.addWeatherCellViewModel(for: "Seoul") { result in
            print(result)
        }
    }
}
