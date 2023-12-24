//
//  WeatherDetailModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/24.
//

import Foundation

struct WeatherDetailResponse: Codable {
    let cnt : Int
    let list : [WeatherDetail]
}

