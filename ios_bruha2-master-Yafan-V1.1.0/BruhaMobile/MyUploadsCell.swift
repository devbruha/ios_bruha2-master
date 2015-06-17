//
//  MyUploadsCell.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-17.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

class MyUploadsCell: UITableViewCell {

    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var uploadImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
