//
//  Unit.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/19.
//

import Foundation

enum Unit: String, CaseIterable {
    case fahrenheit = "imperial"
    case celsius = "metric"
    
    var displayName: String {
        get {
            switch(self) {
            case .fahrenheit :
                return "Fahrenheit"
            case .celsius :
                return "Celsius"
            }
        }
    }
}

