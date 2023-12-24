//
//  LabelCellViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/22.
//

import Foundation

class LabelCellViewModel : WeatherDetailViewModelBySection {
    private var title : String = ""
    
    func setViewModel(with something: Any?) {
        guard let cityName = something as? String else {
            self.title = "unknown"
            return
        }
        self.title = cityName
    }
    
    func getViewModel() -> [String] {
        return [title]
    }
}
