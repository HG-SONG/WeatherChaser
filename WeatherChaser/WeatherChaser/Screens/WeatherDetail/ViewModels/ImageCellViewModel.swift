//
//  ImageCellViewModel.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/24.
//

import Foundation

class ImageCellViewModel: WeatherDetailViewModelBySection {
    private var title: String = ""
    private var imageName: String = ""
    private var texts = [String]()

    func setViewModel(with something: Any?) {
        switch something {
        case let data as Clouds:
            self.handleClouds(data)
        case let data as Wind:
            self.handleWind(data)
        case let data as SunSetAndRise:
            self.handleSunSetAndRise(data)
        case let data as Rain:
            self.handleRain(data)
        case let data as Snow:
            self.handleSnow(data)
        default:
            break
        }
    }

    func getViewModelAsString() -> [String] {
        return [title, imageName] + texts
    }
    
    private func handleClouds(_ data: Clouds) {
        texts.append(data.all.convertToCloudCover())
        imageName = "cloud.jpg"
        title = "Cloud cover"
    }

    private func handleWind(_ data: Wind) {
        texts.append(data.deg.convertToDirection())
        texts.append(data.speed.formatAsTwoDecimalPlaces() + "m/sec")
        imageName = "wind.jpg"
        title = "Wind"
    }

    private func handleSunSetAndRise(_ data: SunSetAndRise) {
        texts.append(data.sunrise.convertToHHmm(isSunrise: true))
        texts.append(data.sunset.convertToHHmm(isSunrise: false))
        imageName = "sunset.jpg"
        title = "Sunrise & Sunset"
    }

    private func handleRain(_ data: Rain) {
        texts.append("⛆ " + data.amountFor1h!.formatAsTwoDecimalPlaces() + "mm")
        imageName = "precipitation.png"
        title = "Precipitation 1h"
    }

    private func handleSnow(_ data: Snow) {
        texts.append("❆ " + data.amountFor1h!.formatAsTwoDecimalPlaces() + "mm")
        imageName = "precipitation.png"
        title = "Precipitation 1h"
    }
}

