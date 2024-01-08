//
//  LocationManager.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/13.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private var locationManager = CLLocationManager()
    private var stateDetermineCompletionHandler: (() -> Void)?
    private var completionHandler: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    func checkLocationAuthorization(completion : @escaping () -> Void) {
        DispatchQueue.global().async {
            self.stateDetermineCompletionHandler = completion
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                    return
                default:
                    self.stateDetermineCompletionHandler?()
                    self.stateDetermineCompletionHandler = nil
                }
            } else {
                
                ErrorManager.showExitAlert(error: .locationServiceOff)
            }
        }
    }
    
    func requestLocation(completion: @escaping (CLLocation) -> Void) {
        completionHandler = completion
        locationManager.requestLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            completionHandler?(location)
            completionHandler = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let error = error as NSError
        
        if error.code == 0 {
            return
        } else {
            ErrorManager.showExitAlert(error: .deniedLocationAuth)
            completionHandler = nil
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        stateDetermineCompletionHandler?()
        stateDetermineCompletionHandler = nil
    }
}
