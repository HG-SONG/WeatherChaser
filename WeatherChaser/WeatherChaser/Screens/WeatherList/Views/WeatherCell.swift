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
        disableSelectionHighlight()
        configureBackgroundImageView(viewModel)
        configureNameLabel(viewModel)
        configureThisMomentLabel()
        configureUpdatedAt(viewModel)
        configureTemperatureLabel(viewModel)
        configureTemperatureWeatherSymbol(viewModel)
        configureTemperatureSubStackView(viewModel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutNameLabel()
        layoutThisMomentLabel()
        layoutUpdatedAtLabel()
        layoutTemperatureLabel()
        layoutTemperatureSubStackView()
        layoutWeatherSymbol()
    }
    
    // MARK: Layout Configurations
    
    private func layoutNameLabel() {
        if !self.subviews.contains(nameLabel) {
            self.addSubview(nameLabel)
        }
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                nameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 20.0),
                nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0)
            ]
        )
    }
    
    private func layoutThisMomentLabel() {
        if !self.subviews.contains(thisMomentLabel) {
            self.addSubview(thisMomentLabel)
        }
        
        thisMomentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                thisMomentLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
                thisMomentLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor)
            ]
        )
    }
    
    private func layoutUpdatedAtLabel() {
        if !self.subviews.contains(updatedAtLabel) {
            self.addSubview(updatedAtLabel)
        }
        
        updatedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                updatedAtLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5.0),
                updatedAtLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5.0)
            ]
        )
    }
    
    private func layoutTemperatureLabel() {
        if !self.subviews.contains(temperatureMainLabel) {
            self.addSubview(temperatureMainLabel)
        }
        
        temperatureMainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                temperatureMainLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -20.0),
                temperatureMainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20.0)
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
                weatherSymbol.heightAnchor.constraint(equalTo: self.nameLabel.heightAnchor),
                weatherSymbol.widthAnchor.constraint(equalTo: self.weatherSymbol.heightAnchor),
                weatherSymbol.leadingAnchor.constraint(equalTo: self.temperatureSubStackView.trailingAnchor,constant: 20.0),
                weatherSymbol.centerYAnchor.constraint(equalTo: self.temperatureSubStackView.centerYAnchor)
            ]
        )
    }
    
    private func layoutTemperatureSubStackView(){
        
        if !self.subviews.contains(temperatureSubStackView) {
            self.addSubview(temperatureSubStackView)
        }
        
        temperatureSubStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                temperatureSubStackView.leadingAnchor.constraint(equalTo: temperatureMainLabel.trailingAnchor, constant: 15.0),
                temperatureSubStackView.centerYAnchor.constraint(equalTo: temperatureMainLabel.centerYAnchor)
            ]
        )
    }
}

// MARK: Property Configurations

extension WeatherCell {

    private func disableSelectionHighlight() {
        self.selectionStyle = .none
    }
    
    private func configureBackgroundImageView(_ viewModel: WeatherCellViewModel) {
        self.backgoundImageView.image = UIImage(named: viewModel.backgroundImageName)
        self.backgoundImageView.contentMode = .scaleToFill
        self.backgoundImageView.clipsToBounds = true
        self.backgroundView = self.backgoundImageView
    }
    
    private func configureTemperatureLabel(_ viewModel: WeatherCellViewModel) {
        self.temperatureMainLabel.text = viewModel.temperature
        self.temperatureMainLabel.font = self.temperatureMainLabel.font.withSize(80.0)
    }
    
    private func configureTemperatureWeatherSymbol(_ viewModel: WeatherCellViewModel) {
        self.weatherSymbol.image = UIImage(systemName: viewModel.iconDesc)
    }
    
    private func configureNameLabel(_ viewModel: WeatherCellViewModel){
        self.nameLabel.text = viewModel.city
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
    }
    
    private func configureThisMomentLabel() {
        self.thisMomentLabel.text = "at this moment"
        self.thisMomentLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
    }
    
    private func configureUpdatedAt(_ viewModel: WeatherCellViewModel) {
        self.updatedAtLabel.text = "Updated • " + viewModel.currentTime
        self.updatedAtLabel.textColor = .lightGray
        self.updatedAtLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
    }
    
    private func configureTemperatureSubStackView(_ viewModel: WeatherCellViewModel){
        self.temperatureSubStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let max = "Max • " + viewModel.maxTemperature
        let feelsLike = "Feels like • " + viewModel.feelsLikeTemperature
        let min = "Min • " + viewModel.minTemperature
        
        let maxLabel = makeLabel(text: max, fontColor: .maxTemp)
        let feelsLikeLabel = makeLabel(text: feelsLike, fontColor: .feelsTemp)
        let minLabel = makeLabel(text: min, fontColor: .minTemp)
        
        self.temperatureSubStackView.axis = .vertical
        self.temperatureSubStackView.addArrangedSubview(maxLabel)
        self.temperatureSubStackView.addArrangedSubview(feelsLikeLabel)
        self.temperatureSubStackView.addArrangedSubview(minLabel)
    }
    
    private func makeLabel(text:String,fontColor:UIColor) -> UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = fontColor
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        return label
    }
    
    
}
