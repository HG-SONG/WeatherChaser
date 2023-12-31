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
    private let cityNameTextField = UITextField(frame: .zero)
    
    var delegate: SaveDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setBarButtons()
        setCityNameTextField()
    }
    
    private func setBarButtons() {
        self.saveButton = UIBarButtonItem(title: "Save", style: .plain, target:self, action: #selector(saveButtonTouched))
        
        self.navigationItem.setRightBarButton(saveButton, animated: true)
    }
    
    private func setCityNameTextField() {
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
        ]
        self.cityNameTextField.attributedPlaceholder = NSAttributedString(string: "Enter the city name", attributes: placeholderAttributes)
        
        
        self.cityNameTextField.borderStyle = .roundedRect
        self.cityNameTextField.textColor = .white
        self.cityNameTextField.backgroundColor = .black
        self.cityNameTextField.layer.cornerRadius = 5.0
        self.cityNameTextField.layer.borderColor = UIColor.white.cgColor
        self.cityNameTextField.layer.borderWidth = 1.0
        
        self.view.addSubview(cityNameTextField)
        
        self.cityNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                cityNameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                cityNameTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50.0)
            ]
        )
    }
    
    @objc private func saveButtonTouched() {
        guard let cityName = cityNameTextField.text else {
            return
        }
        
        addCityViewModel.addWeatherCellViewModel(for: cityName, lat: nil, lon: nil) { viewModel,error in
            guard let viewModel = viewModel else {
                guard let networkError = error as? NetworkError else {
                    ErrorManager.showAlertForUnknown()
                    return
                }
                ErrorManager.showAlert(error: networkError)
                return
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("UpdateCellNotification"), object: nil, userInfo: ["data": viewModel])
            self.delegate?.saveButtonTouched()
        }
    }
}
