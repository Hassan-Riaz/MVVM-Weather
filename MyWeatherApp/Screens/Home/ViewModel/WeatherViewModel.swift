//
//  EmployeesViewModel.swift
//  MyWeatherApp
//
//  Created by Munsif Hayat on 01/02/2022.
//

import Foundation

class WeatherViewModel: NSObject {
    
    var weather = [ConsolidatedWeather]()
    var outputDelegate: WeatherViewModelDelegate?
    
    init(delegate: WeatherViewModelDelegate) {
        self.outputDelegate = delegate
    }
    
    func getWeather( woid : String) {
        print("woid" , woid)
        let networkManager = NetworkManager()
        let endpoint = "location/\(woid)"
        guard let url = URL(string: Constants.BaseURL + endpoint) else { fatalError("Invalid URL") }
        
        // Request data from the backend
        networkManager.request(fromURL: url) { (result: Result<Weather, Error>) in
            switch result {
            case .success(let weatherData):
                if let weatherDetails = weatherData.consolidated_weather {
                    self.fetchData(weather: weatherDetails)
                }
            case .failure(let error):
                debugPrint("We got a failure trying to get the users. The error we got was: \(error.localizedDescription)")
            }
        }
    }
    
    var tommorrowWeather: WeatherDetailsViewModel? {
        if  weather.count > 1 {
            let weatherDetailObj = createWeatherModel(weatherDetails: weather[1])
            return weatherDetailObj
        }
        return nil
    }
    
    func fetchData(weather: [ConsolidatedWeather]) {
        self.weather = weather // Cache
        if let weatherObj = self.tommorrowWeather {
            self.outputDelegate?.loadData(weather: weatherObj)
        }
    }
    
    func createWeatherModel(weatherDetails: ConsolidatedWeather) -> WeatherDetailsViewModel {
        
        let weather_state_name = weatherDetails.weather_state_name ?? ""
        let weather_state_abbr = weatherDetails.weather_state_abbr ?? ""
        let the_temp = weatherDetails.the_temp ?? 0.0
        let max_temp = weatherDetails.max_temp ?? 0.0
        let min_temp = weatherDetails.min_temp ?? 0.0
        let wind_speed = weatherDetails.wind_speed ?? 0.0
        let air_pressure = weatherDetails.air_pressure ?? 0.0
        let humidity = weatherDetails.humidity ?? 0
        
        
        return WeatherDetailsViewModel(weather_state_name: weather_state_name, weather_state_abbr: weather_state_abbr, the_temp: the_temp, max_temp: max_temp, min_temp: min_temp, wind_speed: wind_speed, air_pressure: air_pressure, humidity: humidity)
    }
    
}

protocol WeatherViewModelDelegate {
    func loadData(weather: WeatherDetailsViewModel)
}
