//
//  ExploreSubView.swift
//  BruhaMobile
//
//  Created by lye on 15/6/1.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

@IBDesignable class ExploreSubView: UIView {
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myButton: UIButton!
    
        var view:UIView!
        @IBInspectable var mytitleLabelText: String?
            {
            get
            {
                return titleLabel.text
            }
            set(mytitleLabelText)
            {
                titleLabel.text = mytitleLabelText
            }
        }
        @IBInspectable var myCustomImage:UIImage?
            {
            get
            {
                return myImage.image
            }
            set(myCustomImage)
            {
                myImage.image = myCustomImage
            }
        }
        override init(frame: CGRect)
        {
            super.init(frame: frame)
            setup()
        }
        required init(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
            setup()
        }
        func setup(){
            view = loadViewFromNib()
            view.frame = bounds
            view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
            addSubview(view)
        }
        
        func loadViewFromNib() -> UIView
        {
            let bundle = NSBundle(forClass:self.dynamicType)
            let nib = UINib(nibName:"ExploreSubView", bundle: bundle)
            let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
            
            return view
        }

}
