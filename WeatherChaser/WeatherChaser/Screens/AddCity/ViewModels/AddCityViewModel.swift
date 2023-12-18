//
//  AddCityViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

class AddCityViewModel {
    func addWeatherCellViewModel(for city: String?, lat:  String?, lon: String?, completion: @escaping (WeatherCellViewModel?,Error?) -> Void) {
        var weatherURL: URL!
        
        if let city = city {
            weatherURL = URLManager.setURLforWeather(of: city)
        } else {
            if lat != nil && lon != nil {
                weatherURL = URLManager.setURLforWeatherByGPS(lat: lat!, lon: lon!)
            }
        }
        
        if weatherURL == nil {
            ErrorManager.showAlert(error: NetworkError.decodingFailure)
            return
        }
        
        let weatherResource = Resource<WeatherResponse>(url: weatherURL) { data in
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse
        }
        
        NetworkManager().fetch(resource: weatherResource) { (result) in
            switch result {
            case .success(let weatherResponse):
                    let viewModel = WeatherCellViewModel(weather: weatherResponse)
                    completion(viewModel,nil)

            case .failure(let error):
                completion(nil,error)
            }
        }
    }
}
