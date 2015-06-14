//
//  EventsTableViewCell.swift
//  BruhaMobile
//
//  Created by lye on 15/6/2.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var circView: CircleView!
    @IBOutlet weak var rectView: RectView!
    
    let tapRec = UITapGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tapRec.addTarget(self, action: "tappedView:")
        self.addGestureRecognizer(tapRec)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
    //    super.setSelected(selected, animated: animated)

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
