//
//  ViewController.swift
//  BonVoya
//

import UIKit
import Parse
import MapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var tableView: UITableView!

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }
        
        //This will tell the table view that the delegate and data source is present in the current view controller
        tableView.dataSource = self
        tableView.delegate = self
        
        //hide the navigation bar since, on the dashboard, we're not going to have a navbar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("Locations = \(locValue.latitude) \(locValue.longitude)")
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude) // <- New York
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            placemarks?.forEach { (placemark) in
                if let city = placemark.locality
                {
                    print(city)
                }
            }
        })
    }
    
    //This function returns the number of table cells to show (this changes dynamically for each place
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "row: \(indexPath.row)"
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
