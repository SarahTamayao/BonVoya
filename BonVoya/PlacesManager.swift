//
//  PlacesManager.swift
//  BonVoya
//

import Foundation
import CoreLocation
import Alamofire

class PlacesManager {
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
    
    func getNearbyPlaces(coordinate: CLLocationCoordinate2D, completion: @escaping ([Result]) -> ()) {
        
        let headers: HTTPHeaders = [
            "X-RapidAPI-Host": "trueway-places.p.rapidapi.com",
            "X-RapidAPI-Key": "d21d23c616msh0dfcc69840c5774p1c3012jsne9d41c7837b3"
        ]
        
        let radius: String = "10000" //i believe this is in meters?
        let language: String = "en"
        
        let placesURL = URL(string: "https://trueway-places.p.rapidapi.com/FindPlacesNearby?location=\(coordinate.latitude)%2C\(coordinate.longitude)&radius=\(radius)&language=\(language)")!
        let placesURLConvertible: Alamofire.URLConvertible = placesURL
        
        
        // this is going to be a real request, this might put all the returned data in a data structure perhaps?
        AF.request(placesURLConvertible, headers: headers).responseData { response in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                do {
                    let placesDataResponseBody = try JSONDecoder().decode(PlacesResponseBody.self, from: data)
                    let result = placesDataResponseBody.results

                    completion(result)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        
        //for debugging purposes, just to get an overview of the response being returned from the api
//                AF.request(placesURLConvertible, headers: headers).responseData { response in
//                    debugPrint(response)
//                }
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
