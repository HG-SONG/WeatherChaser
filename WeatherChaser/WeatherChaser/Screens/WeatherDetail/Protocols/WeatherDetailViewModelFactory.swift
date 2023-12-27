//
//  WeatherDetailViewModelBySection.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/24.
//

import Foundation

protocol WeatherDetailViewModelFactory {
    static func makeCellViewModel(at section : Int) -> WeatherDetailViewModelBySection
}

@objc protocol WeatherDetailViewModelBySection {
    func setViewModel(with something: Any?)
    @objc optional func getViewModelAsString() -> [String]
    @objc optional func getViewModelAsObject() -> [Any]
}
