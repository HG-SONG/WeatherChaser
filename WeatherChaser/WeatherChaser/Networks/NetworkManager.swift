//
//  NetworkManager.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

class NetworkManager {
    func fetch<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                     completion(resource.parsed(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}

struct Resource<T> {
    let url: URL
    let parsed: (Data) -> T?
}
