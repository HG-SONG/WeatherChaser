//
//  StringExtension.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/17.
//

import Foundation

extension String {
    func replaceSpacesWithDash() -> String {
        return self.replacingOccurrences(of: " ", with: "-")
    }
}
