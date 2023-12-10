//
//  Coordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/03.
//

import Foundation

@objc protocol Coordinator {
    func changeViewController()
    @objc optional func changeViewController(with viewModel: Any)
}
