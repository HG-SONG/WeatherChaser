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
    }

    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            completionHandler?(location)
            completionHandler = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location request 실패: \(error.localizedDescription)")
        completionHandler = nil
    }
}
