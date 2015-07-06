//
//  VerticalDotLine.swift
//  BruhaMobile
//
//  Created by lye on 15/7/6.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

@IBDesignable
class VerticalDotLine: UIView {

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
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context,
            UIColor.orangeColor().CGColor)
        let dashArray:[CGFloat] = [0,0,4,8]
        CGContextSetLineDash(context, 0, dashArray,4)
        CGContextMoveToPoint(context, 0, 130)
        CGContextAddQuadCurveToPoint(context, 0, 0, 0, 0)
        CGContextStrokePath(context)
        
    }


}
