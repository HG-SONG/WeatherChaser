//
//  ErrorManager.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/17.
//

import UIKit

class ErrorManager {
    
    static func showAlert(error: NetworkError) {
        DispatchQueue.main.async {
            var message : String
            
            switch error {
            case .decodingFailure :
                message = "The city could not be found. Check the city name"
            case .noData :
                message = "No response."
            case .offline :
                message = "Can not connect to server. Check your network connection"
            }
            
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            guard let topViewController = UIApplication.shared.windows.first?.rootViewController else {
                return
            }
            topViewController.present(alertController, animated: true)
        }
    }
    
    static func showAlertForUnknown() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: "Unknown Error", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            
            if let topViewController = UIApplication.shared.windows.first?.rootViewController {
                topViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    static func showExitAlert(error:FatalError) {
        DispatchQueue.main.async {
            var message : String = ""
            switch error {
            case .noAPIKey :
                message = "Cannot retrieve the authentication key. Please check your network status."
            case .deniedLocationAuth :
                message = "Location Services permission has been denied. Please open the 'Settings', go to 'Privacy & Security' and then 'Location Services', and allow location permission for the app."
            case .locationServiceOff :
                message = "Location services are turned off. Please open the 'Settings', go to 'Privacy & Security' and then 'Location Services'. turn it on, and restart the app."
            }
            
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let exitAction = UIAlertAction(title: "Exit", style: .default) { _ in
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                exit(0)
            }
            
            alertController.addAction(exitAction)
            
            if let topViewController = UIApplication.shared.windows.first?.rootViewController {
                topViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

enum FatalError {
    case noAPIKey
    case deniedLocationAuth
    case locationServiceOff
}
