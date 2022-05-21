//
//  ItineraryViewCell.swift
//  BonVoya
//
//  Created by navid ro on 5/20/22.
//

import UIKit

class ItineraryViewCell: UITableViewCell {
    
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var myImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
