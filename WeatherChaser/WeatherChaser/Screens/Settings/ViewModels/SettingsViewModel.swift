//
//  SettingsViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/19.
//

import Foundation

class SettingsViewModel {
    let units = Unit.allCases
    
    var selectedUnit: Unit {
        get{
            let userDefaults = UserDefaults.standard
            var unitValue = ""
            if let value = userDefaults.value(forKey: "unit") as? String {
                unitValue = value
            }
            return Unit(rawValue: unitValue)!
        }
        
        set{
            let userDefault = UserDefaults.standard
            userDefault.set(newValue.rawValue, forKey:"unit")
            userDefault.set(newValue.rawValue, forKey:"selected")
        }
    }
}
