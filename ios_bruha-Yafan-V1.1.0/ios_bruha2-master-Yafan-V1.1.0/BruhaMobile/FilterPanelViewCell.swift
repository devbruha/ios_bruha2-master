//
//  FilterPanelViewCell.swift
//  BruhaMobile
//
//  Created by lye on 15/6/24.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class FilterPanelViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UIView!
    @IBOutlet weak var picker: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.layer.borderWidth = 1.0
        titleLabel.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    class var expandedHeight: CGFloat {get {return 150}}
    class var defaultHeight: CGFloat {get {return 25}}
    
    func checkHeight(){
        picker.hidden = (frame.size.height < FilterPanelViewCell.expandedHeight)
    }
    func watchFrameChanges() {
        addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New|NSKeyValueObservingOptions.Initial, context: nil)
        checkHeight()
    }
    
    func ignoreFrameChanges() {
        removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }

}
