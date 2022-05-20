//
//  ItineraryViewController.swift
//  BonVoya
//
//  Created by Fiza Metla on 5/20/22.
//

import UIKit

class ItineraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "row: \(indexPath.row)"
        
        return cell
    }
}


