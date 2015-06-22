//
//  DropDownTableViewCell.swift
//  DropDownBox
//
//  Created by Ryan O'Neill on 2015-06-16.
//  Copyright (c) 2015 lye. All rights reserved.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {

    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
