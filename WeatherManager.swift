//
//  WeatherManager.swift
//  Clima
//
//  Created by Saiprasad lokhande on 18/11/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//
    
import Foundation
import CoreLocation
    
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/3.0/onecall?appid=b7221f23207bbecf3289e0e4a9cd48c0&units=metric";
//    &lat=19.2176466&lon=73.1328863
    
    var weatherDelegate : WeatherManagerDelegate?
    func featchWeather(lat: Double, lon: Double){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        print(urlString);
        performRequest(urlString: urlString)
    }
    func featchWeatherUsingLatLong(location: CLLocation){
        let lat = location.coordinate.latitude;
        let lon = location.coordinate.longitude;
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        print(urlString);
        performRequest(urlString: urlString)
    }
    
    
    func performRequest(urlString : String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){(data,response,error) in
                if(error != nil){
                    self.weatherDelegate?.didFailedWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather =  self.parseJson(weatherData: safeData){
                    self.weatherDelegate?.didUpdateWidget(weather: weather)}
                }
            }
                                            
            task.resume()
        }
    }
    
    
    func parseJson(weatherData : Data)-> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodeData =
            try decoder.decode(WeatherModel.self, from: weatherData)
            print(decodeData.current.temp)
            let weather = WeatherModel(lat: decodeData.lat, lon: decodeData.lon, timezone: decodeData.timezone, current: decodeData.current)
            return weather;
        }
        catch{
            weatherDelegate?.didFailedWithError(error: error)
            return nil;
        }
    }
    
}
