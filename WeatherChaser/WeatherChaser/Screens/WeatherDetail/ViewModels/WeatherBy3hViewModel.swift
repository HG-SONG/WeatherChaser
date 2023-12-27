//
//  WeatherBy3hViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/27.
//

import Foundation

class WeatherBy3hViewModel {
    private var date : String = ""
    private var time : String = ""
    private var imageName : String = ""
    private var temparature : String = ""
    private var rainPrecipitation : String = "⛆ "
    private var snowPrecipitation : String = "❆ "
    private var pop : String = ""
    
    func setupViewModel(_ viewModel : WeatherDetail) {
        setupDateAndTime(fullDate: viewModel.dt)
        self.imageName = viewModel.weather.first!.main
        self.temparature = viewModel.main.temp.formatAsDegree()
        self.rainPrecipitation += (viewModel.rain?.amountFor3h?.formatAsTwoDecimalPlaces() ?? "0.00mm")
        self.snowPrecipitation += (viewModel.snow?.amountFor3h?.formatAsTwoDecimalPlaces() ?? "0.00mm")
        self.pop = viewModel.pop.formatAsTwoDecimalPlaces()
    }
    
    private func setupDateAndTime(fullDate: Int) {
        let splited = fullDate.splitDate()
        self.date = splited[0]
        self.time = splited[1]
    }
    
}
