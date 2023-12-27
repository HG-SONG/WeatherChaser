//
//  IntExtension.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/26.
//

import Foundation

extension Int {
    func convertToCloudCover() -> String {
        return "\(self) / 100"
    }
    
    func convertToDirection() -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((Double(self) / 45.0).rounded()) % 8
        let direction = directions[index]
        
        return direction
    }
    
    func convertToHHmm(isSunrise: Bool) -> String {
        let timestamp = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: date)
        
        if isSunrise {
            return "☀︎ " + formattedDate
        } else {
            return "☼ " + formattedDate
        }
    }
    
    func splitDate() -> [String] {
        let timestamp = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-DD"
        let firstFormatted = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "HH:mm"
        let secondFormatted = dateFormatter.string(from: date)
        
        return [firstFormatted,secondFormatted]
    }
}
