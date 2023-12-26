//
//  WeatherDetailViewModelCreator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/24.
//

import Foundation

class WeatherDetailViewModelCreator : WeatherDetailViewModelFactory {
    static func makeCellViewModel(at section : Int) -> WeatherDetailViewModelBySection {
        switch section {
        case 0,1 :
            return LabelCellViewModel()
        case 2 :
            return ImageCellViewModel() 
        case 3 :
            return LabelCellViewModel() // 임시
        default :
            return LabelCellViewModel() // 임시
        }

    }
}
