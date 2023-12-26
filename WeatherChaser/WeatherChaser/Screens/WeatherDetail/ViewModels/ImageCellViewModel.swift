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
    }
    
    func getViewModel() -> [String] {
        var array = [title,imageName]
        
        for item in texts {
            array.append(item)
        }
        return array
    }
    
}

