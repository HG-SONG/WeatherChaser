//
//  WeatherListTableViewController.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/03.
//

import UIKit
import CoreLocation

class WeatherListTableViewController: UITableViewController {
    private let locationManager = LocationManager()
    private var addCityButton : UIBarButtonItem!
    private var settingsButton : UIBarButtonItem!
    private var weatherListViewModel = WeatherListViewModel()

    override init(style: UITableView.Style) {
        super.init(style: style)
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name("UpdateCellNotification"), object: nil)
    }
    
    @objc func updateData(_ notification: Notification) {
        if let data = notification.userInfo?["data"] as? WeatherCellViewModel {
            weatherListViewModel.addWeatherCellInViewModel(data)
        }
        self.tableView.reloadData()
    }
    
    func addCity(cellViewModel: WeatherCellViewModel) {
        self.weatherListViewModel.addWeatherCellInViewModel(cellViewModel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var delegate: BarButtonActionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        commonInit()
    }
    
    private func commonInit() {
        setBarButtons()
        self.tableView.backgroundColor = .black
        self.tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        requestUserLocation()
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
    
    private func requestUserLocation() {
        self.locationManager.requestLocation { location in
            let tmp = AddCityViewModel()
            let lat = location.coordinate.latitude.description
            let lon = location.coordinate.longitude.description
            
            tmp.addWeatherCellViewModel(for: nil, lat: lat, lon: lon) { viewModel in
                self.weatherListViewModel.addWeatherCellInViewModel(viewModel)
                self.tableView.reloadData()
            }
        }
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
//        let reversedViewModel = weatherListViewModel.reversed()
//        print(weatherListViewModel)
//        let weatherViewModel = reversedViewModel[indexPath.row]
        let weatherViewModel = self.weatherListViewModel.modelAt(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
        
        cell.commonInit(weatherViewModel)
        return cell
    }
    
}

