//
//  WeatherAPICaller.swift
//  BonVoya
//

import Foundation
import CoreLocation

class WeatherAPICaller {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws {
        let apiKey: String = "4cdc43b784690435fdb782327f18f41f"
        let unit: String = "imperial" //supports standard, metric, and imperial
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=\(unit)") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data") }
    }
}
