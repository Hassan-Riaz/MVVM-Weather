//
//  Cities.swift
//  MyWeatherApp
//
//  Created by Munsif Hayat on 02/02/2022.
//

import Foundation

//typealias City = [CitiesList]

// MARK: - Employee

struct Citylist : Codable {
    let woeid: String
    let cityName : String
    
    enum CodingKeys: String, CodingKey {
        case woeid
        case cityName = "city"
    }
}

struct cityRecords : Codable {
    let cities: [Citylist]
}



