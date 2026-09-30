//
//  AwardsTableViewCell.swift
//  POP!Corn
//
//  Created by Giuseppe Tansella and Luca Mastroianni on 02/07/2019.
//  Copyright © 2019 unicampania.it. All rights reserved.
//

import UIKit

class AwardsTableViewCell: UITableViewCell {

    @IBOutlet var badgeName: UILabel!
    @IBOutlet var badgeDesc: UILabel!
    @IBOutlet var badgeImage: UIImageView!
    @IBOutlet var earned: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
