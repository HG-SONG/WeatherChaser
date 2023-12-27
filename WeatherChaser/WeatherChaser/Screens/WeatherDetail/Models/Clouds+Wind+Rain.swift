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
    let amountFor1h : Double?
    let amountFor3h : Double?
    
    enum CodingKeys: String, CodingKey {
        case amountFor1h = "1h"
        case amountFor3h = "3h"
    }
}

struct Snow : Codable {
    let amountFor1h : Double?
    let amountFor3h : Double?
    
    enum CodingKeys: String, CodingKey {
        case amountFor1h = "1h"
        case amountFor3h = "3h"
    }
}
