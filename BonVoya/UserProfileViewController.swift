//
//  UserProfileViewController.swift
//  BonVoya
//
//  Created by Navid on 18/05/2022.
//

import UIKit


class UserProfileViewController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var bioBackground: UIImageView!
    @IBOutlet weak var bioField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //force light mode if the user's phone is on dark mode
        overrideUserInterfaceStyle = .light
        
        // Do any additional setup after loading the view.
        profileName.layer.masksToBounds = true
        profileName.layer.cornerRadius = profileName.frame.height / 2

        bioBackground.layer.masksToBounds = true
        profileName.layer.cornerRadius = 10
        profileName.text = "Hello \(LoginViewController.username)"
    }
}
