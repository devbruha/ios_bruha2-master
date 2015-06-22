//
//  SignInButton.swift
//  BruhaMobile
//
//  Created by lye on 15/6/22.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

@IBDesignable
class SignInButton: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [1.0, 1.0, 1.0, 1.0]
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        CGContextMoveToPoint(context, 130, 2)
        CGContextAddLineToPoint(context,130,48)
        CGContextStrokePath(context)
        
        let button1   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button1.frame = CGRectMake(30, 20, 80, 10)
        button1.setTitle("Login", forState: UIControlState.Normal)
        button1.setTitleColor(UIColor.whiteColor(), forState: .Normal )
        button1.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)
        self.addSubview(button1)
        
        let button2   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button2.frame = CGRectMake(150, 20, 80, 10)
        button2.setTitle("Sign Up", forState: UIControlState.Normal)
        button2.setTitleColor(UIColor.whiteColor(), forState: .Normal )
        button2.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)
        self.addSubview(button2)
    }
}
