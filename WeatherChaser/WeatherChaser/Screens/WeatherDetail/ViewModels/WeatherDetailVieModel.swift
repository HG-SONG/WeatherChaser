//
//  WeatherDetailVieModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/22.
//

import Foundation

class WeatherDetailViewModel {
    private var sectionZeroViewModel = [LabelCellViewModel]()
    private var sectionOneViewModel = LabelCellViewModel(title: "")
    
    func setupTopSectionViewModel(_ cellSummary : [String]) {
        let cityName = cellSummary[0]
        let currentTemperature = cellSummary[1]
        let description = cellSummary[2]
        
        self.sectionZeroViewModel.append(LabelCellViewModel(title: cityName))
        self.sectionZeroViewModel.append(LabelCellViewModel(title: currentTemperature))
        self.sectionOneViewModel.title = description
    }
    
    func fetchWeatherDetail(){
        //GET요청
    }
    
    func modelAt(_ indexPath : IndexPath) -> LabelCellViewModel?{
        switch indexPath.section {
        case 0:
            return self.sectionZeroViewModel[indexPath.item]
        case 1:
            return self.sectionOneViewModel
        case 2:
            return nil
        case 3:
            return nil
        default:
            return nil
        }
    }
}

