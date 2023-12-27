//
//  FiveDaysWeatherViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/27.
//

import Foundation

class FiveDaysCellViewModel : WeatherDetailViewModelBySection {
    private var list = [WeatherBy3hViewModel]()

    func setViewModel(with something: Any?) {
        guard let fiveDaysInfo = something as? WeatherDetailResponse else {
            return
        }
        
        for item in fiveDaysInfo.list {
            let weatherBy3h = WeatherBy3hViewModel()
            weatherBy3h.setupViewModel(item)
            self.list.append(weatherBy3h)
        }
    }

    func getViewModelAsObject() -> [Any] {
        return [self.list]
    }
}
