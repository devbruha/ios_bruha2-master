//
//  AddictionTableViewCell.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-18.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

class AddictionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circView: CircView!
    @IBOutlet weak var rectView: RectangularView!
    @IBOutlet weak var addictionLabel: UILabel!
    @IBOutlet weak var addictionImage: UIImageView!
    
    let tapRec = UITapGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rectView.hidden = true
        tapRec.addTarget(self, action: "tappedView:")
        self.addGestureRecognizer(tapRec)
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func tappedView(sender:UITapGestureRecognizer){
        
        if(!circView.hidden && !rectView.hidden){
            circView.hidden = true
        }else if(circView.hidden){
            circView.hidden = false
            rectView.hidden = true
        }else{
            circView.hidden = true
            rectView.hidden = false
        }
    }


}
