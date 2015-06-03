//
//  PushButtonView.swift
//  BruhaMobile
//
//  Created by lye on 15/6/2.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

@IBDesignable
class CircularButtonView: UIButton{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        UIColor.blueColor().colorWithAlphaComponent(0.5).setFill()
        path.fill()
        
        /*var label = UILable(frame:CGRectMake(100, 100, 40, 20))
        label.text = "Cars"
        label.textColor = UIColor.whiteColor()
        self.view.addSubview(label)*/
    }

}
