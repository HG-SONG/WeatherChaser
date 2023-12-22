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
    private var retryButton = UIButton(frame: .zero)
    var delegate: CoordinatorDelegate?
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name("UpdateCellNotification"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.weatherListViewModel.updateUnit()
        self.tableView.reloadData()
    }
    
    private func commonInit() {
        setBarButtons()
        setRetryButton()
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
        delegate?.addCityButtonTouched()
    }
    
    @objc private func settingsButtonTouched() {
        delegate?.settingsButtonTouched()
    }
    
    @objc func updateData(_ notification: Notification) {
        if let data = notification.userInfo?["data"] as? WeatherCellViewModel {
            weatherListViewModel.addWeatherCellInViewModel(data)
        } // 이거도 pop -> wiilAppear에서 처리할까? 일단 커밋따고 고민해보자.
        self.tableView.reloadData()
    }
    
    func addCity(cellViewModel: WeatherCellViewModel) {
        self.weatherListViewModel.addWeatherCellInViewModel(cellViewModel)
    }
    
    private func requestUserLocation() {
        self.locationManager.requestLocation { location in
            let tmp = AddCityViewModel()
            let lat = location.coordinate.latitude.description
            let lon = location.coordinate.longitude.description
            
            tmp.addWeatherCellViewModel(for: nil, lat: lat, lon: lon) { viewModel,error in
                guard let viewModel = viewModel else {
                    guard let networkError = error as? NetworkError else {
                        ErrorManager.showAlertForUnknown()
                        return
                    }
                    ErrorManager.showAlert(error: networkError)
                    self.showRetryButton()
                    return
                }
                self.hideRetryButton()
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
        self.hideRetryButton()
        
        let weatherViewModel = self.weatherListViewModel.modelAt(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
        
        cell.commonInit(weatherViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.weatherCellTouched(at:indexPath)
    }
    
}
// MARK: RetryButton
extension WeatherListTableViewController {
    func showRetryButton() {
        DispatchQueue.main.async {
            self.retryButton.isHidden = false
        }
    }
    
    func hideRetryButton() {
        DispatchQueue.main.async {
            self.retryButton.isHidden = true
        }
    }
    
    private func setRetryButton() {
        self.retryButton.isHidden = false
        self.retryButton.titleLabel?.font = UIFont.systemFont(ofSize: 50.0, weight: .bold)
        self.retryButton.setTitle("☛ Retry", for: .normal)
        self.retryButton.addTarget(self, action: #selector(retrybuttonTouched), for: .touchUpInside)
        self.view.addSubview(retryButton)
        
        self.retryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                self.retryButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.retryButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 50.0)
            ]
        )
    }
    
    @objc private func retrybuttonTouched() {
        requestUserLocation()
    }
}

