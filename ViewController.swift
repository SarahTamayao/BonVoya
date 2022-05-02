//
//  ViewController.swift
//  BonVoya
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var userGreeting: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userGreeting.text = "Hi " + LoginViewController.username + "," //we can access username from LoginViewController because it's static
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
