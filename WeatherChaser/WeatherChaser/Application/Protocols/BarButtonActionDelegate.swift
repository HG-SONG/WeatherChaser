//
//  ButtonActionDelegate.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

protocol BarButtonActionDelegate {
    func addCityButtonTouched()
    func settingsButtonTouched()
}

protocol SaveDelegate {
    func saveButtonTouched()
}
