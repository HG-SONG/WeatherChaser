//
//  ImageCellViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/24.
//

import Foundation

class ImageCellViewModel: WeatherDetailViewModelBySection {
    private var title : String = ""
    private var imageName : String = ""
    private var texts = [String]()
    
    func setViewModel(with something: Any?) {
        if let data = something as? Clouds {
            self.texts.append(data.all.convertToCloudCover())
            self.imageName = "cloud.jpg"
            self.title = "Cloud cover"
        } else if let data = something as? Wind {
            self.texts.append(data.deg.convertToDirection())
            self.texts.append(data.speed.formatAsAmount() + "m/sec")
            self.imageName = "wind.jpg"
            self.title = "Wind"
        } else if let data = something as? SunSetAndRise {
            self.texts.append(data.sunrise.convertToHHmm(isSunrise: true))
            self.texts.append(data.sunset.convertToHHmm(isSunrise: false))
            self.imageName = "sunset.jpg"
            self.title = "Sunrise & Sunset"
        } else if let data = something as? Rain {
            self.texts.append(data.amount.formatAsAmount() + "mm")
            self.imageName = "precipitation.png"
            self.title = "Precipitation 1h"
        } else {
            //Error
        }
    }
    
    func getViewModel() -> [String] {
        var array = [title,imageName]
        
        for item in texts {
            array.append(item)
        }
        return array
    }
    
}

