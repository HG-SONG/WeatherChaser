//
//  WeatherCellViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

class WeatherCellViewModel {
    let weather : WeatherResponse
    var temperature: Double
    var feelsLikeTemperature: Double
    
    init(weather: WeatherResponse) {
        self.weather = weather
        self.temperature = weather.main.temp
        self.feelsLikeTemperature = weather.main.feels_like
    }
    
    var city: String {
        return weather.name
    }
    
}
