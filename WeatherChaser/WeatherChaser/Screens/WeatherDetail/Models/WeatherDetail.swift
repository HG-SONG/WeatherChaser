//
//  WeatherDetail.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/24.
//

import Foundation

struct WeatherDetail : Codable {
    let dt : Int
    let main : Weather
    let weateher : [WeatherDesc]
    let clouds : Clouds
    let wind : Wind
    let pop : Double
    let rain : Rain?
    let dt_txt : String
}
