//
//  ItineraryCell.swift
//  BonVoya
//
//  Created by Navid on 20/05/2022.
//

import UIKit

class ItineraryCell: UITableViewCell {

    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myLabel2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
