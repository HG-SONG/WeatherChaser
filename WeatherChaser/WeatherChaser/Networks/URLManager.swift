//
//  URLManager.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

struct URLManager {
    
    static func setURLforWeather(of city: String) -> URL? {
        guard let environmentVariable = UserDefaults.standard.string(forKey: "environmentVariable") else {
            ErrorManager.showExitAlert(error: .noAPIKey)
            return URL(string:"Error")
        }
        
        guard let retrievedApiKey = ProcessInfo.processInfo.environment[environmentVariable] else {
            ErrorManager.showExitAlert(error: .noAPIKey)
            return URL(string: "Error")
        }
        
        let userDefaults = UserDefaults.standard
        let unit = (userDefaults.value(forKey: "unit") as? String) ?? "metric"
        let cityName = city.replaceSpacesWithPlus()
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(retrievedApiKey)&units=\(unit)") else {
            return nil
        }
        
        return url
    }
    
    static func setURLforWeatherByGPS(lat: String, lon: String) -> URL {
        guard let environmentVariable = UserDefaults.standard.string(forKey: "environmentVariable") else {
            ErrorManager.showExitAlert(error: .noAPIKey)
            return URL(string:"Error")!
        }
        
        guard let retrievedApiKey = ProcessInfo.processInfo.environment[environmentVariable] else {
            ErrorManager.showExitAlert(error: .noAPIKey)
            return URL(string: "Error")!
        }
        
        let userDefaults = UserDefaults.standard
        let unit = (userDefaults.value(forKey: "unit") as? String) ?? "metric"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(retrievedApiKey)&units=\(unit)")!
        
        return url
    }
    
    static func setURLforWeatherDetail(of city: String) -> URL {
        guard let environmentVariable = UserDefaults.standard.string(forKey: "environmentVariable") else {
            ErrorManager.showExitAlert(error: .noAPIKey)
            return URL(string:"Error")!
        }
        
        guard let retrievedApiKey = ProcessInfo.processInfo.environment[environmentVariable] else {
            ErrorManager.showExitAlert(error: .noAPIKey)
            return URL(string: "Error")!
        }
        
        let userDefaults = UserDefaults.standard
        let unit = (userDefaults.value(forKey: "unit") as? String) ?? "metric"
        let cityName = city.replaceSpacesWithPlus()
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(retrievedApiKey)&units=\(unit)")!
        
        return url
    }

    private func apiKey() -> String {
        guard let environmentVariable = UserDefaults.standard.string(forKey: "environmentVariable") else {
            ErrorManager.showExitAlert(error: .noAPIKey)
            return ""
        }
        
        guard let retrievedApiKey = ProcessInfo.processInfo.environment[environmentVariable] else {
            ErrorManager.showExitAlert(error: .noAPIKey)
            return ""
        }
        
        return retrievedApiKey
    }
}
