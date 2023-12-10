//
//  DoubleExtension.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/08.
//

import Foundation

extension Double {
    func formatAsDegree() -> String {
        return String(format: "%.0f", self) //+ Degree.celsius.rawValue
    }
}