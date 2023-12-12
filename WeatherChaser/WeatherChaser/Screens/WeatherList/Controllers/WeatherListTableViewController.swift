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
        self.tableView.backgroundColor = .black
        self.tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
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

extension WeatherListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weatherViewModel = weatherListViewModel.modelAt(indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
        
        cell.commonInit(weatherViewModel)
        return cell
    }
}
