//
//  ticketVerticalLine.swift
//  BruhaMobile
//
//  Created by lye on 15/6/29.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

@IBDesignable
class ticketVerticalLine: UIView {

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
        let components: [CGFloat] = [169/255, 173.0/255, 175/255, 1.0]
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        CGContextMoveToPoint(context, 2, 10)
        CGContextAddLineToPoint(context, 2, 130)
        CGContextStrokePath(context)
        
    }


}
