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
        
        setupNameCellViewModel(cityName)
        setupCurrentTempCellViewModel(currentTemperature)
        setupDescriptionCellViewModel(description)
        setupImageCellViewModel(cellSummary)
    }
    
    func setupLowerSectionWithFetching(of city: String){
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
            return self.sectionTwoViewModel[indexPath.item]
        case 3:
            return nil
        default:
            return nil
        }
    }
    
    private func setSectionThree(with fetchedData : WeatherDetailResponse) {
        
    }
    
    private func setupNameCellViewModel(_ cityName: String) {
        let nameCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 0)
        nameCellViewModel.setViewModel(with: cityName)
        self.sectionZeroViewModel.append(nameCellViewModel)
    }

    private func setupCurrentTempCellViewModel(_ currentTemperature: String) {
        let currentTempCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 0)
        currentTempCellViewModel.setViewModel(with: currentTemperature)
        self.sectionZeroViewModel.append(currentTempCellViewModel)
    }

    private func setupDescriptionCellViewModel(_ description: String) {
        let descriptionCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 1)
        descriptionCellViewModel.setViewModel(with: description)
        self.sectionOneViewModel = descriptionCellViewModel
    }
    
    private func setupImageCellViewModel(_ cellSummary : WeatherCellViewModel) {
        let wind = cellSummary.weather.wind
        let clouds = cellSummary.weather.clouds
        let sunriseAndSet = cellSummary.weather.sys
        var rain : Rain
        if cellSummary.weather.rain == nil {
            rain = Rain(amount: .zero)
        } else {
            rain = cellSummary.weather.rain!
        }
        
        let rainCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 2)
        rainCellViewModel.setViewModel(with: rain)
        self.sectionTwoViewModel.append(rainCellViewModel)
        
        let cloudsCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 2)
        cloudsCellViewModel.setViewModel(with: clouds)
        self.sectionTwoViewModel.append(cloudsCellViewModel)
        
        let windCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 2)
        windCellViewModel.setViewModel(with: wind)
        self.sectionTwoViewModel.append(windCellViewModel)
        
        let sunCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 2)
        sunCellViewModel.setViewModel(with: sunriseAndSet)
        self.sectionTwoViewModel.append(sunCellViewModel)
        
    }
}

