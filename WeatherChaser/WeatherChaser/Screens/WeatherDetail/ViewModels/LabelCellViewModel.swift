//
//  LabelCellViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/22.
//

import Foundation

class LabelCellViewModel : WeatherDetailViewModelBySection {
    private var text : String = ""
    
    func setViewModel(with something: Any?) {
        guard let cityName = something as? String else {
            self.text = "unknown"
            return
        }
        self.text = cityName
    }
    
    func getViewModelAsString() -> [String] {
        return [text]
    }
}
