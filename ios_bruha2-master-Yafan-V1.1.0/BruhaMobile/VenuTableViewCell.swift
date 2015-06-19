//
//  VenuTableViewCell.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-19.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

class VenuTableViewCell: UITableViewCell {

    @IBOutlet weak var venuImage: UIImageView!
    
    @IBOutlet weak var venuLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
