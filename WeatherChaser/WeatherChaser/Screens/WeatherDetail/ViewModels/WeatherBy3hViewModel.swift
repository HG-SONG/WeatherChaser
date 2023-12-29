//
//  WeatherBy3hViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/27.
//

import Foundation

class WeatherBy3hViewModel {
    var date : String = ""
    var time : String = ""
    var imageName : String = ""
    var temparature : String = ""
    var rainPrecipitation : String = "⛆ "
    var snowPrecipitation : String = "❆ "
    var pop : String = "☔︎ "
    
    func setupViewModel(_ viewModel : WeatherDetail) {
        setupDateAndTime(fullDate: viewModel.dt)
        setupImageName(viewModel.weather.first?.main ?? "error")
        self.temparature = viewModel.main.temp.formatAsDegree().makeUnitSymbol()
        self.rainPrecipitation += (viewModel.rain?.amountFor3h?.formatAsTwoDecimalPlaces() ?? "0.00") + "mm"
        self.snowPrecipitation += (viewModel.snow?.amountFor3h?.formatAsTwoDecimalPlaces() ?? "0.00") + "mm"
        self.pop += viewModel.pop.formatAsProb()
    }
    
    private func setupDateAndTime(fullDate: Int) {
        let splited = fullDate.splitDate()
        self.date = splited[0]
        self.time = splited[1]
    }
    
    private func setupImageName(_ text : String) {
        switch text {
        case "Rain":
            self.imageName = "cloud.heavyrain.fill"
        case "Snow":
            self.imageName = "snowflake"
        case "Clouds":
            self.imageName = "cloud.fill"
        case "Wind" :
            self.imageName = "wind"
        case "Clear" :
            self.imageName = "sun.max.fill"
        default :
            self.imageName = "questionmark.app.fill"
        }
    }
}
