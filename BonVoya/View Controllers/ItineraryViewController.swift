//
//  ItineraryViewController.swift
//  BonVoya
//
//  Created by Fiza Metla on 5/20/22.
//

import UIKit

class ItineraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TitleView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
  
    
 
    let notes = ["We will wake up at 9:30AM to catch Breakfast and climb the Eifel Tower", "During my visit to the museum, I need to get a selfie with Mona Lisa!", "Have to book a guide with good reviews for the Catacombs.", "I will catch a taxi to the Gate."]
    let places = ["Eiffel Tower", "Lourve Museum", "Catacombs", "Arc De Triompe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let nib = UINib(nibName: "ItineraryViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ItineraryViewCell")
    tableView.delegate = self
    tableView.dataSource = self
        
        TitleView.layer.masksToBounds = true
        TitleView.layer.cornerRadius = 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItineraryViewCell", for: indexPath) as! ItineraryViewCell
        
        let place = places[indexPath.row]
        cell.placeLabel.text = places[indexPath.row]
        cell.myImageView.backgroundColor = .clear
        cell.noteLabel.text = notes[indexPath.row]
        cell.myImageView.image = UIImage(named: place)

   
        return cell
    }
}


