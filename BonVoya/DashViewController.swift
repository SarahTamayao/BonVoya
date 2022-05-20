//
//  DashViewController.swift
//  BonVoya
//

import UIKit
import Parse
import MapKit
import Foundation
import Alamofire
import AlamofireImage

class DashViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityViewBorder: UIImageView!
    @IBOutlet weak var cityBackground: UIImageView!
    
    static var currentLocationCoordinates: CLLocationCoordinate2D?
    
    //Creates location manager object
    var locationManager = CLLocationManager()
    
//    var weatherManager = WeatherAPICaller()
//    var weather: ResponseBody?
        
    //Once the iPhone has loaded
    override func viewDidLoad() {
        super.viewDidLoad() //this always comes first
        
        //Ask iPhone for permission to use location services
        self.locationManager.requestWhenInUseAuthorization()
        
        //If the user has granted permission
        if CLLocationManager.locationServicesEnabled() {
            //Location manager setup
            locationManager.delegate = self // Will receive update events
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers // Indicates desired accuracy of location to 3km
            locationManager.startUpdatingLocation()
        }
        
        //This will tell the table view that the delegate and data source is present in the current view controller
        tableView.dataSource = self
        tableView.delegate = self
        
        //Hide the navigation bar since, on the dashboard, we're not going to have a navbar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //Specify properies for cityBackground
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = CGRect(x:0, y:0, width: cityBackground.frame.width, height: cityBackground.frame.height)
        blurEffectView.center = cityBackground.center
        self.cityBackground.addSubview(blurEffectView)
        blurEffectView.effect = blurEffect
        
        //Specify properies for cityViewBorder
        cityViewBorder.clipsToBounds = false
        cityViewBorder.layer.shadowColor = UIColor.black.cgColor
        cityViewBorder.layer.shadowOpacity = 1
        cityViewBorder.layer.shadowOffset = CGSize.zero
        cityViewBorder.layer.shadowRadius = 5
        cityViewBorder.layer.shadowPath = UIBezierPath(roundedRect: cityViewBorder.bounds, cornerRadius: 10).cgPath
        cityViewBorder.layer.cornerRadius = 15
    }
    
    //locationManager will retrieve the coordinates of the iPhone and change the text label
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        print("Locations = \(locValue.latitude) \(locValue.longitude)") // Prints latitude and longitude to console for debugging
        
        let geoCoder = CLGeocoder()
        
        //Location variable will store a CLLocation object that contains the latitude and longitude
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        
        //Use geoCoder variable to perform a "reverse geocode," which is to take the coordinates and return a city
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            placemarks?.forEach { (placemark) in
                if let city = placemark.locality // Locality just means city, so if "placemark" has a locality, print it
                {
                    self.cityLabel.text = city
                }
            }
        })
        
        let weatherManager = WeatherManager()
        weatherManager.getCurrentTemperature(coords: locValue) { currentTemperature in
            self.weatherLabel.text = "Weather: \(currentTemperature)"
        }
        
        let placeManager = PlacesManager()
        placeManager.getNearbyPlaces(coordinate: locValue)
    }
    
//    func callPlacesAPI(coordinateVar: CLLocationCoordinate2D) -> Void {
//        //API Caller Places API Documentation as Places List By Radius
//        let headers = [
//            "X-RapidAPI-Host": "opentripmap-places-v1.p.rapidapi.com",
//            "X-RapidAPI-Key": "d21d23c616msh0dfcc69840c5774p1c3012jsne9d41c7837b3"
//        ]
//
//        let radiusValue = 500
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://opentripmap-places-v1.p.rapidapi.com/%7Blang%7D/places/radius?radius=\(radiusValue)&lon=\(coordinateVar.longitude)&lat=\(coordinateVar.latitude)")! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
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
//        //; End of API call
//    }
    
    //Returns the number of table cells to show (this changes dynamically for each attraction, when we implement it)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    //This controls the logic for each cell, any logic that is cell-specific (i.e., retrieving info from API) will be put into this function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashCell") as! DashCell
        
        cell.textLabel?.text = "row: \(indexPath.row)"
        
        /*
         //Defining API dictionaries to outlets
         let activity = ____.["inputAPIactivityNameDictionary"] as! String
         let desc = ___["inputAPIdescriptionDictionary"] as! String
         
         //Accessing outlets
         cell.activityLabel = activity
         cell.descLabel = desc
         */
        return cell
    }
}
