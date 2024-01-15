//
//  WeatherDetailViewModelTests.swift
//  WeatherDetailViewModelTests
//
//  Created by SONG on 1/15/24.
//

import XCTest

final class WeatherDetailViewModelTests: XCTestCase {
    
    private var weatherDetailViewModel : WeatherDetailViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.weatherDetailViewModel = WeatherDetailViewModel()
    }
    
    override func tearDownWithError() throws {
        self.weatherDetailViewModel = nil
        try super.tearDownWithError()
    }
    
    func testCommonInit() {
        self.weatherDetailViewModel.commonInit()
        
        XCTAssertNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 1)))
        XCTAssertNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 3)))
    }
    
    func testSetupUpperSectionViewModel_Rain_Snow_are_nil() {
        let cellSummary = WeatherCellViewModel()
        self.weatherDetailViewModel.setupUpperSectionViewModel(cellSummary)
        
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 0)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 1, section: 0)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 1)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 1, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 2, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 3, section: 2)))
        
        XCTAssertNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 3)))
    }
    
    func testSetupUpperSectionViewModel_Rain_is_nil() {
        let cellSummary = WeatherCellViewModel()
        cellSummary.weather.snow = Snow(amountFor1h: 1.0, amountFor3h: 3.0)
        
        self.weatherDetailViewModel.setupUpperSectionViewModel(cellSummary)
        
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 0)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 1, section: 0)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 1)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 1, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 2, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 3, section: 2)))
        
        XCTAssertNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 3)))
    }
    
    func testSetupUpperSectionViewModel_Snow_is_nil() {
        let cellSummary = WeatherCellViewModel()
        cellSummary.weather.rain = Rain(amountFor1h: 1.0, amountFor3h: 3.0)
        
        self.weatherDetailViewModel.setupUpperSectionViewModel(cellSummary)
        
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 0)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 1, section: 0)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 1)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 1, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 2, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 3, section: 2)))
        
        XCTAssertNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 3)))
    }
    
    func testSetupUpperSectionViewModel_Rain_Snow_Notnil() {
        let cellSummary = WeatherCellViewModel()
        cellSummary.weather.rain = Rain(amountFor1h: 1.0, amountFor3h: 3.0)
        cellSummary.weather.snow = Snow(amountFor1h: 1.0, amountFor3h: 3.0)
        
        self.weatherDetailViewModel.setupUpperSectionViewModel(cellSummary)
        
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 0)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 1, section: 0)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 1)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 1, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 2, section: 2)))
        XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 3, section: 2)))
        
        XCTAssertNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 3)))
    }

    func testSetupLowerSectionWithFetching() {
        let city = "city"
        let expectation = self.expectation(description: "success")
        
        weatherDetailViewModel.setupLowerSectionWithFetching(of: city) {
            expectation.fulfill()
            XCTAssertNotNil(self.weatherDetailViewModel.modelAt(IndexPath(item: 0, section: 3)))
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}


class WeatherCellViewModel {
    let city = "city"
    let temperature = "0.0"
    let weather = WeatherResponse()
}

struct WeatherDetailResponse: Codable {
}

class WeatherResponse {
    let weather = [WeatherDesc()]
    let sys = Mock()
    let clouds = Mock()
    let wind = Mock()
    var rain = Rain(amountFor1h: nil, amountFor3h: nil)
    var snow = Snow(amountFor1h: nil, amountFor3h: nil)
}

class WeatherDesc {
    let description = "description"
}

class Mock : Codable {
    
}

class Rain: Codable {
    let amountFor1h : Double?
    let amountFor3h : Double?
    
    init(amountFor1h: Double?, amountFor3h: Double?) {
        self.amountFor1h = amountFor1h
        self.amountFor3h = amountFor3h
    }
}

class Snow: Codable {
    let amountFor1h : Double?
    let amountFor3h : Double?
    
    init(amountFor1h: Double?, amountFor3h: Double?) {
        self.amountFor1h = amountFor1h
        self.amountFor3h = amountFor3h
    }
}

class LabelCellViewModel : WeatherDetailViewModelBySection {
    func setViewModel(with something: Any?) {
    }
}

class ImageCellViewModel : WeatherDetailViewModelBySection {
    func setViewModel(with something: Any?) {
    }
}

class FiveDaysCellViewModel : WeatherDetailViewModelBySection {
    func setViewModel(with something: Any?) {
    }
}

class WeatherDetail{
}
