//
//  WeatherChaserTests.swift
//  WeatherChaserTests
//
//  Created by SONG on 1/14/24.
//

import XCTest

final class WeatherListViewModelTests: XCTestCase {
    
    private var weatherListViewModel : WeatherListViewModel!
    private var weatherCellViewModel : WeatherCellViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.weatherListViewModel = WeatherListViewModel()
    }
    
    override func tearDownWithError() throws {
        self.weatherListViewModel = nil
        self.weatherCellViewModel = nil
        try super.tearDownWithError()
    }
    
    func testNumberOfRows_zero() {
        let numberOfRows = weatherListViewModel.numberOfRows(0)
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func testNumberOfRows_one() {
        appendMock()
        let numberOfRows = weatherListViewModel.numberOfRows(0)
        XCTAssertEqual(numberOfRows, 1)
    }
    
    func testNumberOfRows_Two() {
        appendMock()
        appendMock()
        let numberOfRows = weatherListViewModel.numberOfRows(0)
        XCTAssertEqual(numberOfRows, 2)
    }

    func testModelAt() {
        appendMock()
        let retrievedModel = weatherListViewModel.modelAt(0)
        XCTAssertTrue(retrievedModel == self.weatherCellViewModel)
    }
    
    func testAddWeatherCellInViewModel() {
        let initialCount = weatherListViewModel.numberOfRows(0)
        let weatherCellViewModel = WeatherCellViewModel(weather: WeatherResponse(contents: 0))
        
        weatherListViewModel.addWeatherCellInViewModel(weatherCellViewModel)

        let finalCount = weatherListViewModel.numberOfRows(0)
        XCTAssertEqual(finalCount, initialCount + 1)
    }
    
    func testReversed() {
        let weatherCellViewModel0 = WeatherCellViewModel(weather: WeatherResponse(contents: 0))
        let weatherCellViewModel1 = WeatherCellViewModel(weather: WeatherResponse(contents: 1))
        
        weatherListViewModel.addWeatherCellInViewModel(weatherCellViewModel0)
        weatherListViewModel.addWeatherCellInViewModel(weatherCellViewModel1)

        let reversedViewModels = weatherListViewModel.reversed()

        XCTAssertEqual(reversedViewModels, [weatherCellViewModel1, weatherCellViewModel0])
    }
    
    func testUpdateUnit_celsius_to_celsius() {
        appendMock()
        self.weatherListViewModel.lastSelectedUnit = Unit.celsius.rawValue
        
        UserDefaults.standard.setValue(Unit.celsius.rawValue, forKey: "selected")
        
        let initialTemperature = weatherCellViewModel.temperature

        weatherListViewModel.updateUnit()

        XCTAssertEqual(initialTemperature, weatherCellViewModel.temperature)
    }
    
    func testUpdateUnit_fahrenheit_to_fahrenheit() {
        appendMock()
        self.weatherListViewModel.lastSelectedUnit = Unit.fahrenheit.rawValue
        
        UserDefaults.standard.setValue(Unit.fahrenheit.rawValue, forKey: "selected")
        
        let initialTemperature = weatherCellViewModel.temperature

        weatherListViewModel.updateUnit()

        XCTAssertEqual(initialTemperature, weatherCellViewModel.temperature)
    }
    
    func testUpdateUnit_fahrenheit_to_celsius() {
        appendMock()
        self.weatherListViewModel.lastSelectedUnit = Unit.fahrenheit.rawValue
        
        UserDefaults.standard.setValue(Unit.celsius.rawValue, forKey: "selected")
        
        let initialTemperature = weatherCellViewModel.temperature

        let predictedResult = (Double(initialTemperature)! - 32.0) * 5/9
        
        weatherListViewModel.updateUnit()

        XCTAssertEqual(predictedResult.formatAsDegree(), weatherCellViewModel.temperature)
    }
    
    func testUpdateUnit_celsius_to_fahrenheit() {
        appendMock()
        self.weatherListViewModel.lastSelectedUnit = Unit.celsius.rawValue
        
        UserDefaults.standard.setValue(Unit.fahrenheit.rawValue, forKey: "selected")
        
        let initialTemperature = weatherCellViewModel.temperature

        let predictedResult = 9/5 * Double(initialTemperature)! + 32.0
        
        weatherListViewModel.updateUnit()

        XCTAssertEqual(predictedResult.formatAsDegree(), weatherCellViewModel.temperature)
    }
    
    func appendMock() {
        let mockWeatherResponse = WeatherResponse(contents: 0)
        self.weatherCellViewModel = WeatherCellViewModel(weather: mockWeatherResponse)
        
        self.weatherListViewModel.addWeatherCellInViewModel(weatherCellViewModel)
    }
}

extension WeatherCellViewModel : Equatable {
    static func == (lhs: WeatherCellViewModel, rhs: WeatherCellViewModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

class WeatherResponse {
    let contents : Double
    
    init(contents: Double) {
        self.contents = contents
    }
}

class WeatherCellViewModel {
    let weather: WeatherResponse
    var temperature: String
    var feelsLikeTemperature: String
    var maxTemperature: String
    var minTemperature: String
    
    init(weather: WeatherResponse) {
        self.weather = weather
        self.temperature = String(weather.contents)
        self.feelsLikeTemperature = String(weather.contents + 5.00)
        self.maxTemperature = String(weather.contents + 10.00)
        self.minTemperature = String(weather.contents - 10.00)
    }
}
