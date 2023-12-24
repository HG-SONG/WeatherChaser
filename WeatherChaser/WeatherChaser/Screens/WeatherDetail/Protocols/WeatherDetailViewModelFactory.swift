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

protocol WeatherDetailViewModelBySection {
    func setViewModel(with something: Any?)
    func getViewModel() -> [String]
}
