//
//  StringExtension.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/17.
//

import Foundation

extension String {
    func replaceSpacesWithDash() -> String {
        return self.replacingOccurrences(of: " ", with: "-")
    }
    
    func makeUnitSymbol() -> String {
        let unit : Unit.RawValue = UserDefaults.standard.value(forKey: "selected") as! Unit.RawValue
        var symbol : String = ""
        switch unit {
        case Unit.celsius.rawValue :
            symbol = "℃"
        case Unit.fahrenheit.rawValue :
            symbol = "℉"
        default:
            symbol = "?"
        }
        return self + symbol
    }
}
