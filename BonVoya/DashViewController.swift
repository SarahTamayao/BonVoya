//
//  DashViewController.swift
//  BonVoya
//

import UIKit
import Parse
import MapKit

class DashViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var tableView: UITableView!

    //Creates location manager object
    var locationManager = CLLocationManager()
    
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
    }
    
    //locationManager will retrieve the coordinates of the iPhone and print it to the console
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
                    // This can be changed to set the text of a label to the city, instead of just printing to console
                    print(city)
                }
            }
        })
    }
    
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
