//
//  NetworkManager.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import Foundation

class NetworkManager {
    func fetch<T>(resource: Resource<T>, completion: @escaping (Result<T, Error>) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let parsedData = try resource.parsed(data)
                DispatchQueue.main.async {
                    if parsedData != nil {
                        completion(.success(parsedData!))
                    } else {
                        completion(.failure(NetworkError.decodingFailure))
                    }
                    
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


struct Resource<T> {
    let url: URL
    let parsed: (Data) throws -> T?
}

enum NetworkError: Error {
    case noData
    case decodingFailure
}
