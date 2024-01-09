//
//  LoadingManager.swift
//  WeatherChaser
//
//  Created by SONG on 2024/01/01.
//

import UIKit

class LoadingManager {
    static func showLoadingIndicator(for type: LoadingType) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else {
                return
            }
            var color : UIColor
            switch type {
            case .fetchingAPIKey :
                color = .yellow
            case .fetchingWeather :
                color = .magenta
            case .locationService :
                color = .cyan
            }
            
            let loadingIndicator: UIActivityIndicatorView
            if let existedView = window.subviews.first(
                where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView {
                loadingIndicator = existedView
            } else {
                loadingIndicator = UIActivityIndicatorView(style: .large)
                loadingIndicator.frame = window.frame
                loadingIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                loadingIndicator.color = color
                
                window.addSubview(loadingIndicator)
            }
            loadingIndicator.startAnimating()
        }
    }
    
    static func hideLoadingIndicator() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else {
                return
            }
            window.subviews.filter({ $0 is UIActivityIndicatorView })
                .forEach { $0.removeFromSuperview() }
        }
    }
}

enum LoadingType {
    case fetchingAPIKey
    case locationService
    case fetchingWeather
}
