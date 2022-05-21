////
////  ImageManager.swift
////  BonVoya
////
////  Created by Tony Makaj on 5/19/22.
////
//
//import Foundation
//import Alamofire
//
//class ImageManager {
//    func getImage(searchQuery: String) -> String {
//        //Retrieve API keys from Keys.plist - ensure that imageAPIKey utilizes an api key from unsplash API
//        var key: NSDictionary?
//        var imageAPIKey: String = ""
//
//        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
//            key = NSDictionary(contentsOfFile: path)
//        }
//
//        if let dict = key {
//            imageAPIKey = dict["imageAPIKey"] as! String
//        }
//
//        let accessKey = imageAPIKey
//
//        let unsplashURL = "https://api.unsplash.com/photos/random/?client_id=\(accessKey)&query=\(searchQuery)"
//        let unsplashURLConvertible: Alamofire.URLConvertible = unsplashURL
//
//        AF.request(unsplashURLConvertible).responseData { response in
//            switch response.result {
//            case .failure (let error):
//                print(error.localizedDescription)
//            case .success (let data):
//                do {
//                    let imageDataResponseBody = try JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
//
//
//
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//}
