//
//  APIKeyFetcher.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/30.
//

import Foundation

class APIKeyFetcher {
    
    static func fetchAPIKey(completion: @escaping (Result<String,Error>) -> Void) {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.value(forKey: "environmentVariable") == nil {
            userDefaults.set("apiKey", forKey: "environmentVariable")
        }
        
        guard let url = URL(string: "https://us-central1-weatherchaserapikey.cloudfunctions.net/getAPIKey") else {
            return
        }
        
        let resource = Resource(url:url ) { data in
            let apiKey = String(data: data, encoding: .utf8)
            return apiKey
        }
        
        LoadingManager.showLoadingIndicator()
        NetworkManager.fetch(resource: resource) { (result) in
            switch result {
            case .success(let apiKey) :
                guard let environmentVariable = UserDefaults.standard.string(forKey: "environmentVariable") else {
                    return
                }
                setenv(environmentVariable, apiKey,1)
                LoadingManager.hideLoadingIndicator()
                completion(.success(apiKey))
            case .failure(let error) :
                LoadingManager.hideLoadingIndicator()
                completion(.failure(error))
            }
        }
    }
}

