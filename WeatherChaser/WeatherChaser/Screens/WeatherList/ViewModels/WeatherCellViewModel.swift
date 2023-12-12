//
//  WeatherCellViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

class WeatherCellViewModel {
    let weather : WeatherResponse
    var temperature: String
    var feelsLikeTemperature: String
    var maxTemperature: String
    var minTemperature: String
    
    init(weather: WeatherResponse) {
        self.weather = weather
        self.temperature = weather.main.temp.formatAsDegree()
        self.feelsLikeTemperature = weather.main.feels_like.formatAsDegree()
        self.maxTemperature = weather.main.temp_max.formatAsDegree()
        self.minTemperature = weather.main.temp_min.formatAsDegree()
    }
    
    var city: String {
        return weather.name
    }
    
    var iconDesc: String {
        guard let iconDesc = self.weather.weather.first?.main else {
            return IconType.nothing.rawValue
        }
        
        switch iconDesc {
        case "Snow":
            return IconType.snow.rawValue
        case "Rain":
            return IconType.rain.rawValue
        case "Clouds":
            return IconType.clouds.rawValue
        default :
            return IconType.nothing.rawValue
        }
    }
    
    var timeDesc: String {
        let currentTime = self.weather.dt
        let sunriseTime = self.weather.sys.sunrise
        let sunsetTime = self.weather.sys.sunset
        
        let timeGap = 1800 
        
        if currentTime >= sunriseTime - timeGap && currentTime <= sunriseTime + timeGap {
            return "sunrise"
        } else if currentTime >= sunsetTime - timeGap && currentTime <= sunsetTime + timeGap  {
            return "sunset"
        } else if currentTime > sunriseTime + timeGap && currentTime < sunsetTime - timeGap {
            return "day"
        } else {
            return "night"
        }
    }
    
    var backgroundImageName : String {
        var wd :String
        
        switch self.iconDesc {
        case IconType.snow.rawValue :
            wd = "snow"
            return wd + "_" + timeDesc + ".jpg"
        case IconType.rain.rawValue :
            wd = "rain"
            return wd + "_" + timeDesc + ".jpg"
        case IconType.clouds.rawValue :
            wd = "clouds"
            return wd + "_" + timeDesc + ".jpg"
        default:
            wd = "nothing"
            return wd + "_" + timeDesc + ".jpg"
        }
    }
    
    var currentTime: String {
        let timestamp = TimeInterval(self.weather.dt)
        let date = Date(timeIntervalSince1970: timestamp)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY-MM-dd HH:mm"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    
}
