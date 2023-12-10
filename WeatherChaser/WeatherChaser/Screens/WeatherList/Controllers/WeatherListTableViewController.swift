//
//  WeatherListTableViewController.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/03.
//

import UIKit

class WeatherListTableViewController: UITableViewController {
    
    private var addCityButton : UIBarButtonItem!
    private var settingsButton : UIBarButtonItem!
    private var weatherListViewModel = WeatherListViewModel()
    
    init(cellViewModel: WeatherCellViewModel?) {
        super.init(nibName: nil, bundle: nil)
        guard let cellViewModel = cellViewModel else {
            return
        }
        self.weatherListViewModel.setWeatherCellViewModel(cellViewModel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var delegate: ButtonActionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        commonInit()
    }
    
    private func commonInit() {
        setBarButtons()
    }
    
    private func setBarButtons() {
        self.settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target:self, action: #selector(settingsButtonTouched))
        
        self.addCityButton = UIBarButtonItem(title: "Add City", style: .plain, target:self, action: #selector(addCityButtonTouched))
        
        self.navigationItem.setLeftBarButton(settingsButton, animated: true)
        
        self.navigationItem.setRightBarButton(addCityButton, animated: true)
    }
    
    @objc private func addCityButtonTouched() {
        delegate?.addCityButtonTouched?()
    }
    
    @objc private func settingsButtonTouched() {
        delegate?.settingsButtonTouched?()
    }
    
}
