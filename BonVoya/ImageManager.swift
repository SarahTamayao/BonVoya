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
//        let accessKey = "AI7KHFOa-7KZ425NuOwGujYfoHUHBDJPX6OdpNNKxw4"
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
