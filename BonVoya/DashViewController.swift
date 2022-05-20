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
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityViewBorder: UIImageView!
    @IBOutlet weak var cityBackground: UIImageView!
    @IBOutlet weak var NotesView: UIImageView!
    
    
    @IBOutlet weak var writenotes: UITextView!
    //Temporary way to access user profile page
    static var currentLocationCoordinates: CLLocationCoordinate2D?
    static var resultData: [Result]?
    
    //Creates location manager object
    var locationManager = CLLocationManager()
    
//    var weatherManager = WeatherAPICaller()
//    var weather: ResponseBody?
        
    //Once the iPhone has loaded
    override func viewDidLoad() {
        super.viewDidLoad() //this always comes first
        //force light mode if the user's phone is on dark mode
        overrideUserInterfaceStyle = .light
        notes.isUserInteractionEnabled = false

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
        blurEffectView.alpha = 0.7
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
        NotesView.layer.masksToBounds = true
        NotesView.layer.cornerRadius = 20
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
            self.weatherLabel.text = "\(round(currentTemperature))°F"
        }
        
        let placeManager = PlacesManager()
        placeManager.getNearbyPlaces(coordinate: locValue) { result in
            DashViewController.resultData = result
            
        }
    }
    
    //Returns the number of table cells to show (this changes dynamically for each attraction, when we implement it)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DashViewController.resultData?.count ?? 20
    }
    
    //This controls the logic for each cell, any logic that is cell-specific (i.e., retrieving info from API) will be put into this function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashCell") as! DashCell
        
        cell.activityLabel.text = "BLAH"

         //Defining API dictionaries to outlets
//         let activity = ____.["inputAPIactivityNameDictionary"] as! String
//         let desc = ___["inputAPIdescriptionDictionary"] as! String
//
//         //Accessing outlets
//         cell.activityLabel = activity
//         cell.descLabel = desc

        return cell
    }
}
