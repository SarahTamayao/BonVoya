//
//  UserProfileViewController.swift
//  BonVoya
//
//  Created by Navid on 18/05/2022.
//

import UIKit


class UserProfileViewController: UIViewController {
    @IBOutlet weak var Biotextfield: UITextView!
    @IBOutlet weak var ProfileView: UIImageView!
    @IBOutlet weak var TextView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileView.backgroundColor = .white
        ProfileView.layer.masksToBounds = true
        ProfileView.layer.cornerRadius = ProfileView.frame.height / 2

        
        TextView.backgroundColor = .gray
        TextView.layer.masksToBounds = true
        Biotextfield.backgroundColor = .gray
        TextView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
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
