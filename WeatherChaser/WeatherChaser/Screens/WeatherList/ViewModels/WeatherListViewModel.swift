//
//  WeatherListViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/04.
//

import Foundation

class WeatherListViewModel {
    private var weatherCellViewModels : [WeatherCellViewModel] = []
    var lastSelectedUnit : Unit.RawValue = UserDefaults.standard.value(forKey: "selected") as! Unit.RawValue
    
    func numberOfRows(_ section: Int?) -> Int {
        return weatherCellViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherCellViewModel {
        return weatherCellViewModels[index]
    }
    
    func addWeatherCellInViewModel(_ viewModel : WeatherCellViewModel) {
        self.weatherCellViewModels.append(viewModel)
    }
    
    func reversed() -> [WeatherCellViewModel] {
        return weatherCellViewModels.reversed()
    }
    
    func updateUnit() {
        let unit : Unit.RawValue = UserDefaults.standard.value(forKey: "selected") as! Unit.RawValue
        
        if lastSelectedUnit == unit {
            return
        }
        
        switch unit {
        case Unit.celsius.rawValue :
            toCelsius()
        case Unit.fahrenheit.rawValue :
            toFahrenheit()
        default:
            break
        }
        lastSelectedUnit = unit
    }

    private func toCelsius() {
        weatherCellViewModels = weatherCellViewModels.map { viewModel in
            let weatherModel = viewModel
            if let temp = Double(weatherModel.temperature) {
                let num = (temp - 32) * 5/9
                weatherModel.temperature = num.formatAsDegree()
            }
            
            if let temp = Double(weatherModel.maxTemperature) {
                let num = (temp - 32) * 5/9
                weatherModel.maxTemperature = num.formatAsDegree()
            }
            
            if let temp = Double(weatherModel.feelsLikeTemperature) {
                let num = (temp - 32) * 5/9
                weatherModel.feelsLikeTemperature = num.formatAsDegree()
            }
            
            if let temp = Double(weatherModel.minTemperature) {
                let num = (temp - 32) * 5/9
                weatherModel.minTemperature = num.formatAsDegree()
            }
            return weatherModel
        }
    }
    
    private func toFahrenheit() {
        weatherCellViewModels = weatherCellViewModels.map { viewModel in
            let weatherModel = viewModel
            if let temp = Double(weatherModel.temperature) {
                let num = (temp * 9/5) + 32
                weatherModel.temperature = num.formatAsDegree()
            }
            
            if let temp = Double(weatherModel.maxTemperature) {
                let num = (temp * 9/5) + 32
                weatherModel.maxTemperature = num.formatAsDegree()
            }
            
            if let temp = Double(weatherModel.feelsLikeTemperature) {
                let num = (temp * 9/5) + 32
                weatherModel.feelsLikeTemperature = num.formatAsDegree()
            }
            
            if let temp = Double(weatherModel.minTemperature) {
                let num = (temp * 9/5) + 32
                weatherModel.minTemperature = num.formatAsDegree()
            }
            
            return weatherModel
        }
    }
}
