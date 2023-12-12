//
//  WeatherResponse.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

struct WeatherResponse: Codable {
    let weather: [WeatherDesc]
    let main: Weather
    let name: String
    let dt: Int
    let sys: SunSetAndRise
}

struct SunSetAndRise: Codable {
    let sunrise: Int
    let sunset: Int
}
