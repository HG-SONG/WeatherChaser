//
//  WeatherCell.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/08.
//

import UIKit

class WeatherCell: UITableViewCell {
    static let identifier = "WeatherCell"
    private var nameLabel = UILabel(frame: .zero)
    private var thisMomentLabel = UILabel(frame: .zero)
    private var temperatureMainLabel = UILabel(frame: .zero)
    private var temperatureSubStackView = UIStackView(frame: .zero)
    private var weatherSymbol = UIImageView(frame:.zero)
    private var backgoundImageView = UIImageView(frame: .zero)
    private var updatedAtLabel = UILabel(frame: .zero)
    
    func commonInit(_ viewModel: WeatherCellViewModel) {
        self.backgoundImageView.image = UIImage(named: viewModel.backgroundImageName)
        self.backgoundImageView.contentMode = .scaleAspectFill
        
        self.nameLabel.text = viewModel.city
        self.nameLabel.font = self.nameLabel.font.withSize(40.0)
        
        self.temperatureLabel.text = viewModel.temperature.formatAsDegree()
        self.temperatureLabel.font = self.temperatureLabel.font.withSize(40.0)
        
        self.weatherSymbol.image = UIImage(systemName: viewModel.iconDesc)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBackbroundImageView()
        layoutNameLabel()
        layoutTemperatureLabel()
        layoutWeatherSymbol()
    }
    
    private func layoutBackbroundImageView() {
        if !self.subviews.contains(backgoundImageView) {
            self.addSubview(backgoundImageView)
        }
        
        backgoundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                
            ]
        )
    }
    
    private func layoutNameLabel() {
        if !self.subviews.contains(nameLabel) {
            self.addSubview(nameLabel)
        }
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
                nameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.5)
            ]
        )
    }
    
    private func layoutTemperatureLabel() {
        if !self.subviews.contains(temperatureLabel) {
            self.addSubview(temperatureLabel)
        }
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                temperatureLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor)
            ]
        )
    }
    
    private func layoutWeatherSymbol() {
        
        if !self.subviews.contains(weatherSymbol) {
            self.addSubview(weatherSymbol)
        }
        
        weatherSymbol.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                weatherSymbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                weatherSymbol.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
                weatherSymbol.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
                weatherSymbol.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20.0)
            ]
        )
    }
}
