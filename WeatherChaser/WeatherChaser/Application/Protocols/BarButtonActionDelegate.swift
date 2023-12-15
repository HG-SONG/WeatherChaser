//
//  ButtonActionDelegate.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

@objc protocol BarButtonActionDelegate {
    @objc optional func addCityButtonTouched()
    @objc optional func settingsButtonTouched()
}

protocol AddCityDelegate {
    func saveButtonTouched(viewModel: WeatherCellViewModel)
}
