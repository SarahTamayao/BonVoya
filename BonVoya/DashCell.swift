//
//  DashCell.swift
//  BonVoya
//

import UIKit

class DashCell: UITableViewCell {
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var activityView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
