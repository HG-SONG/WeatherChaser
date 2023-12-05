//
//  ButtonActionDelegate.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

@objc protocol ButtonActionDelegate {
    @objc optional func addCityButtonTouched()
    @objc optional func settingsButtonTouched()
    @objc optional func backButtonTouched()
}
