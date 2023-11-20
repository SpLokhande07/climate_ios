//
//  WeatherModel.swift
//  Clima
//
//  Created by Saiprasad lokhande on 18/11/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable{
    let lat : Double
    let lon : Double
    let timezone : String
    let current : CurrentWeather
    
}

struct CurrentWeather : Decodable{
    let temp : Double
    let humidity : Int
    let wind_speed : Double
    let wind_gust : Double
    let clouds : Int
    let weather : [Weather]

    var temperatureString : String {
        return String(format: "%.1f",temp)
    }
    
}

struct Weather : Decodable{
    let id : Int
    let main : String
    let description : String
    let icon : String
}
