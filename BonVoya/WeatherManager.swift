//
//  WeatherManager.swift
//  BonVoya
//
//  Created by Tony Makaj on 5/18/22.
//

import Foundation
import CoreLocation
import Alamofire
import AlamofireImage

class WeatherManager {
    func getCurrentTemperature(coords: CLLocationCoordinate2D, completion: @escaping (Double) -> Void) -> Double {
        var currentTemperature: Double = 0.0
        
        //Weather function
        let apiKey: String = "4cdc43b784690435fdb782327f18f41f"
        let unit: String = "imperial" //supports standard, metric, and imperial
        
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coords.latitude)&lon=\(coords.longitude)&appid=\(apiKey)&units=\(unit)")!
        let weatherURLConvertible: Alamofire.URLConvertible = weatherURL
        
        AF.request(weatherURLConvertible).responseData { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    let weatherDataResponseBody = try JSONDecoder().decode(ResponseBody.self, from: data)
                    currentTemperature = weatherDataResponseBody.main.temp
                } catch let error {
                    print(error)
                }
            }
        }
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }

    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}
