//
//  MyUploadsCell.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-17.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

class MyUploadsCell: SWTableViewCell {

    @IBOutlet weak var circView: Circle!
    @IBOutlet weak var rectView: Rect!
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var uploadImage: UIImageView!
    let tapRec = UITapGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userInteractionEnabled = true
        rectView.hidden = true
        tapRec.addTarget(self, action: "tappedView:")
        self.addGestureRecognizer(tapRec)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tappedView(){
        
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
