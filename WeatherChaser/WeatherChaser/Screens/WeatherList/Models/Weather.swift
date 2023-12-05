//
//  Weather.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

struct Weather: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

