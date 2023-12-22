//
//  ButtonActionDelegate.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

protocol CoordinatorDelegate {
    func addCityButtonTouched()
    func settingsButtonTouched()
    func weatherCellTouched(at indexPath : IndexPath)
}

protocol SaveDelegate {
    func saveButtonTouched()
}
