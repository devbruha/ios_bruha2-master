//
//  Line.swift
//  DropDownBox
//
//  Created by Ryan O'Neill on 2015-06-16.
//  Copyright (c) 2015 lye. All rights reserved.
//

import UIKit

class Line: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func drawRect(rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [1.0, 135.0/255, 0.0, 1.0]
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        CGContextMoveToPoint(context, 2, 2)
        CGContextAddLineToPoint(context, 550, 2)
        CGContextStrokePath(context)
    }

}
