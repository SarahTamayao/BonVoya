//
//  UserProfileViewController.swift
//  BonVoya
//
//  Created by Navid on 18/05/2022.
//

import UIKit


class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var bioBackground: UIImageView!
    @IBOutlet weak var bioField: UITextView!
    
    @IBOutlet var tableView: UITableView!
    
    let countries = ["My Trip to Paris", "My Trip to Geneva", "My Trip to Italy", "My Trip to Amsterdam", "My Trip to Greece", "My Trip to Spain"]
    let myData2 = ["From 3/10 to 3/20", "From 4/10 to 4/20", "From 5/10 to 5/20", "From 6/10 to 6/20", "From 7/10 to 7/20", "From 8/10 to 8/20" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //force light mode if the user's phone is on dark mode
        overrideUserInterfaceStyle = .light
        
        // Do any additional setup after loading the view.
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.cornerRadius = profilePicture.frame.height / 2

        bioBackground.layer.masksToBounds = true
        bioBackground.layer.cornerRadius = 20
        profileName.text = "Hello \(LoginViewController.username)"
        
        let nib = UINib(nibName: "ItineraryCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ItineraryCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItineraryCell", for: indexPath) as! ItineraryCell
        let country = countries[indexPath.row]
        cell.myLabel.text = countries[indexPath.row]
        cell.myImageView.backgroundColor = .clear
        cell.myLabel2.text = myData2[indexPath.row]
        cell.myImageView.image = UIImage(named: country)

        

        
       
        return cell
    }
    
    
}
