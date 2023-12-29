//
//  WeatherBy3hView.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/28.
//

import UIKit

class WeatherBy3hView : UIStackView {
    
    func commonInit(viewModel : WeatherBy3hViewModel) {
        self.axis = .vertical
        self.alignment = .center
        self.spacing = 5.0
        setLabel(viewModel.date)
        setLabel(viewModel.time)
        setImageView(viewModel.imageName)
        setLabel(viewModel.temparature)
        setLabel(viewModel.rainPrecipitation)
        setLabel(viewModel.snowPrecipitation)
        setLabel(viewModel.pop)
    }
    
    private func setLabel(_ text: String) {
        let label = UILabel(frame: .zero)
        label.text = text
        self.addArrangedSubview(label)
    }

    private func setImageView(_ text: String) {
        
        let image = UIImage(systemName: text)
        let imageView = UIImageView(image: image)
        self.addArrangedSubview(imageView)
    }

}
