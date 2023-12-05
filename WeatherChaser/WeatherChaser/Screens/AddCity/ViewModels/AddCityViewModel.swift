//
//  AddCityViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

class AddCityViewModel {
    func addWeatherCellViewModel(for city: String, completion: @escaping (WeatherCellViewModel) -> Void) {
        let weatherURL = URLManager.setURLforWeather(of: city)
        
        let weatherResource = Resource<WeatherResponse>(url: weatherURL) { data in
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse
        }
        
        NetworkManager().fetch(resource: weatherResource) { (result) in
            switch result {
            case .success(let weatherResponse):
                    let viewModel = WeatherCellViewModel(weather: weatherResponse)
                    completion(viewModel)

            case .failure(let error):
                print("Network request error: \(error)")
            }
        }
    }
}
