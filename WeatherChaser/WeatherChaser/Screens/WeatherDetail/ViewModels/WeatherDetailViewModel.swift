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
    private var sectionThreeViewModel : WeatherDetailViewModelBySection?
    
    func commonInit(){
        self.sectionZeroViewModel = []
        self.sectionOneViewModel = nil
        self.sectionTwoViewModel = []
        self.sectionThreeViewModel = nil
    }
    
    func setupUpperSectionViewModel(_ cellSummary : WeatherCellViewModel) {
        
        let cityName = cellSummary.city
        let currentTemperature = cellSummary.temperature
        let description = cellSummary.weather.weather.first!.description
        
        setupNameCellViewModel(cityName)
        setupCurrentTempCellViewModel(currentTemperature)
        setupDescriptionCellViewModel(description)
        setupImageCellViewModel(cellSummary)
    }
    
    func setupLowerSectionWithFetching(of city: String,completion: @escaping () -> Void){
        
        let weatherDetailURL = URLManager.setURLforWeatherDetail(of: city)
        
        let weatherDetailResource = Resource<WeatherDetailResponse>(url: weatherDetailURL) { data in
            let weatherDetailResponse = try? JSONDecoder().decode(WeatherDetailResponse.self, from: data)
            return weatherDetailResponse
        }
        
        LoadingManager.showLoadingIndicator(for:.fetchingWeather)
        
        NetworkManager.fetch(resource: weatherDetailResource) { (result) in
            switch result {
            case .success(let response) :
                self.setSectionThree(with: response)
                LoadingManager.hideLoadingIndicator()
                completion()
            case .failure(_) :
                LoadingManager.hideLoadingIndicator()
                completion()
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
            return self.sectionThreeViewModel
        default:
            return nil
        }
    }
    
    private func setSectionThree(with fetchedData : WeatherDetailResponse) {
        let fiveDaysWeatherViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 3)
        fiveDaysWeatherViewModel.setViewModel(with: fetchedData)
        self.sectionThreeViewModel = fiveDaysWeatherViewModel
    }
    
    private func setupNameCellViewModel(_ cityName: String) {
        let nameCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 0)
        nameCellViewModel.setViewModel(with: cityName)
        self.sectionZeroViewModel.append(nameCellViewModel)
    }
    
    private func setupCurrentTempCellViewModel(_ currentTemperature: String) {
        let temp = currentTemperature.makeUnitSymbol()
        let currentTempCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 0)
        currentTempCellViewModel.setViewModel(with: temp)
        self.sectionZeroViewModel.append(currentTempCellViewModel)
    }
    
    private func setupDescriptionCellViewModel(_ description: String) {
        let descriptionCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 1)
        descriptionCellViewModel.setViewModel(with: description)
        self.sectionOneViewModel = descriptionCellViewModel
    }
    
    private func setupImageCellViewModel(_ cellSummary : WeatherCellViewModel) {
        let rain = cellSummary.weather.rain ?? Rain(amountFor1h: .zero, amountFor3h: .zero)
        let snow = cellSummary.weather.snow ?? Snow(amountFor1h: .zero, amountFor3h: .zero)
        
        let rainCellViewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 2)
        rainCellViewModel.setViewModel(with: rain)
        rainCellViewModel.setViewModel(with: snow)
        self.sectionTwoViewModel.append(rainCellViewModel)
        
        setupCellViewModelAtSectionTwo(for: cellSummary.weather.clouds)
        setupCellViewModelAtSectionTwo(for: cellSummary.weather.wind)
        setupCellViewModelAtSectionTwo(for: cellSummary.weather.sys)
    }
    
    private func setupCellViewModelAtSectionTwo<T: Codable>(for data: T) {
        var viewModel: WeatherDetailViewModelBySection
        viewModel = WeatherDetailViewModelCreator.makeCellViewModel(at: 2)
        viewModel.setViewModel(with: data)
        self.sectionTwoViewModel.append(viewModel)
    }
}

