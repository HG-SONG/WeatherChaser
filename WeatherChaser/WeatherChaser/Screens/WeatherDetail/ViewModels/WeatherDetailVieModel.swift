//
//  WeatherDetailVieModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/22.
//

import Foundation

class WeatherDetailViewModel {
    private var sectionZeroViewModel = [WeatherDetailViewModelBySection?]()
    private var sectionOneViewModel : WeatherDetailViewModelBySection?
    private var sectionTwoViewModel = [WeatherDetailViewModelBySection?]()
    
    func setupUpperSectionViewModel(_ cellSummary : WeatherCellViewModel) {
        let cityName = cellSummary.city
        let currentTemperature = cellSummary.temperature
        let description = cellSummary.weather.weather.first!.description
        
        let nameCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 0)
        nameCellViewModel.setViewModel(with: cityName)
        
        let currentTempCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 0)
        currentTempCellViewModel.setViewModel(with: currentTemperature)
        
        let descriptionCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 1)
        descriptionCellViewModel.setViewModel(with: description)
        
        self.sectionZeroViewModel.append(nameCellViewModel)
        self.sectionZeroViewModel.append(currentTempCellViewModel)
        self.sectionOneViewModel = descriptionCellViewModel
    }
    
    func fetchWeatherDetail(of city: String){
        let weatherDetailURL = URLManager.setURLforWeatherDetail(of: city)
        
        let weatherDetailResource = Resource<WeatherDetailResponse>(url: weatherDetailURL) { data in
            let weatherDetailResponse = try? JSONDecoder().decode(WeatherDetailResponse.self, from: data)
            return weatherDetailResponse
        }
        
        NetworkManager.fetch(resource: weatherDetailResource) { (result) in
            switch result {
            case .success(let weatherDetailResponse) :
                print(weatherDetailResponse)
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    func modelAt(_ indexPath : IndexPath) -> WeatherDetailViewModelBySection?{
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

