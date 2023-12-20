//
//  WeatherListViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/04.
//

import Foundation

class WeatherListViewModel {
    private var weatherCellViewModels : [WeatherCellViewModel] = []
    private var lastSelectedUnit : Unit.RawValue = UserDefaults.standard.value(forKey: "selected") as! Unit.RawValue
    
    func numberOfRows(_ section: Int?) -> Int {
        return weatherCellViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherCellViewModel {
        return weatherCellViewModels[index]
    }
    
    func addWeatherCellInViewModel(_ viewModel : WeatherCellViewModel) {
        self.weatherCellViewModels.append(viewModel)
    }
    
    func reversed() -> [WeatherCellViewModel] {
        return weatherCellViewModels.reversed()
    }

}
