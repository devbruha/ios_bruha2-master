//
//  SoldTableViewCell.swift
//  BruhaMobile
//
//  Created by lye on 15/7/6.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class SoldTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
