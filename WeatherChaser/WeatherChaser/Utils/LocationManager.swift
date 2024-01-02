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
    private var completionHandler: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .authorizedWhenInUse, .authorizedAlways:
                    break
                case .denied, .restricted:
                    break
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                @unknown default:
                    break
                }
            } else {
                print("Location services are not enabled")
                self.locationManager.requestWhenInUseAuthorization()
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
        ErrorManager.showExitAlert(error: .deniedLocationAuth)
        completionHandler = nil
    }
}
