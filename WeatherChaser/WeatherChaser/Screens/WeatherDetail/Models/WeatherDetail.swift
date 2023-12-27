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
    let weather : [WeatherDesc]
    let pop : Double
    let rain : Rain?
    let snow : Snow?
    let dt_txt : String
}
