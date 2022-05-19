//
//  PlacesManager.swift
//  BonVoya
//
//  Created by Diana Rivas on 5/18/22.
//

import Foundation
import CoreLocation
import Alamofire

class PlacesManager {
    
    //API Places Caller
//    func getNearbyAPI(coordinate: CLLocationCoordinate2D, completion: @escaping () -> ()) {
//        let headers = [
//            "X-RapidAPI-Host": "trueway-places.p.rapidapi.com",
//            "X-RapidAPI-Key": "d21d23c616msh0dfcc69840c5774p1c3012jsne9d41c7837b3"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://trueway-places.p.rapidapi.com/FindPlacesNearby?location=\(coordinate.latitude)%2C\(coordinate.longitude)&radius=10000&language=en")! as URL,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
//            }
//        })
//
//        dataTask.resume()
//    }
    //; end of API call
    
    func getNearbyPlaces(coordinate: CLLocationCoordinate2D, completion: @escaping () -> ()) {
        
        let headers = [
                  "X-RapidAPI-Host": "trueway-places.p.rapidapi.com",
                  "X-RapidAPI-Key": "d21d23c616msh0dfcc69840c5774p1c3012jsne9d41c7837b3"
              ]
        
        let apiKey: String = "4cdc43b784690435fdb782327f18f41f"
        let radius: String = "10000" //in meters?
        let language: String = "en"
        
        let placesURL = URL(string: "https://trueway-places.p.rapidapi.com/FindPlacesNearby?location=\(coordinate.latitude)%2C\(coordinate.longitude)&radius=\(radius)&language=\(language)")!
        let placesURLConvertible: Alamofire.URLConvertible = placesURL
    
        
        AF.request(placesURLConvertible).responseData { response in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                do {
                    let placesDataResponseBody = try JSONDecoder().decode(PlacesResponseBody.self, from: data)
                    let result = placesDataResponseBody.results[0].id
                    
                    
                    print(result)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
        let address = "Rio de Janeiro, Brazil"

        getCoordinateFrom(address: address) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            // don't forget to update the UI from the main thread
            DispatchQueue.main.async {
                print(address, "Location:", coordinate) // Rio de Janeiro, Brazil Location: CLLocationCoordinate2D(latitude: -22.9108638, longitude: -43.2045436)
            }
        }
    }
    
    
}

struct PlacesResponseBody: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let id: String
    let name: String
    let location: Location
    let types: [String]
    let distance: Int
}

struct Location: Decodable {
    let lat: Double
    let lng: Double
}
