//
//  WeatherListViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/04.
//

import Foundation

class WeatherListViewModel {
    private var weatherCellViewModels : [WeatherCellViewModel] = []
    
    init(weathers: [WeatherCellViewModel]) {
        self.weatherCellViewModels = weathers
    }
    
    func numberOfRows(_ section: Int?) -> Int {
        return weatherCellViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherCellViewModel {
        return weatherCellViewModels[index]
    }
}
