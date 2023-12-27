//
//  Clouds+Wind+Rain.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/24.
//

import Foundation

struct Clouds : Codable {
    let all: Int
}

struct Wind : Codable {
    let speed : Double
    let deg : Int
}

struct Rain : Codable {
    let amount : Double
    
    enum CodingKeys: String, CodingKey {
        case amount = "3h"
    }
}

struct Snow : Codable {
    let amount : Double
    
    enum CodingKeys: String, CodingKey {
        case amount = "3h"
    }
}
