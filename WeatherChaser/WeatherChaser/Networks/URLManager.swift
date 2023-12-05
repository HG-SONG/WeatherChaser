//
//  URLManager.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

struct URLManager {
    static func setURLforWeather(of city: String) -> URL {
        
        let userDefaults = UserDefaults.standard
        let unit = (userDefaults.value(forKey: "unit") as? String) ?? "metric"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=3f38d0611c913b55c3b0beb801842ad6&units=\(unit)")!
        
        return url
    }
}
