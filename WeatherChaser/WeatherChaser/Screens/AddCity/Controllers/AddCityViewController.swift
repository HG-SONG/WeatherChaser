//
//  AddCityViewController.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import UIKit

class AddCityViewController : UIViewController {
    private var addCityViewModel = AddCityViewModel()
    private var saveButton : UIBarButtonItem!
    
    var delegate: AddCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        setBarButtons()
    }
    
    private func setBarButtons() {
        self.saveButton = UIBarButtonItem(title: "Save", style: .plain, target:self, action: #selector(saveButtonTouched))
        
        self.navigationItem.setRightBarButton(saveButton, animated: true)
    }
    
    @objc private func saveButtonTouched() {
        addCityViewModel.addWeatherCellViewModel(for: "Seoul", lat: nil, lon: nil) { viewModel in
            self.delegate?.saveButtonTouched(viewModel: viewModel)
        }
    }
}
