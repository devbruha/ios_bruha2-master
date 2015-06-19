//
//  VenuCirc.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-19.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

@IBDesignable
class VenuCirc: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        UIColor.blueColor().colorWithAlphaComponent(0.65).setFill()
        path.fill()
        
        var carName = ["Nissan","Volkswagen"]
        
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [1.0, 135.0/255, 0.0, 1.0]
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        CGContextMoveToPoint(context, 8, 60)
        CGContextAddLineToPoint(context, 150, 60)
        CGContextStrokePath(context)
        
        var priceLabel: UILabel = UILabel()
        priceLabel.frame = CGRectMake(5, 63, 150, 30)
        priceLabel.backgroundColor = UIColor.clearColor()
        priceLabel.textColor = UIColor.whiteColor()
        priceLabel.textAlignment = NSTextAlignment.Center
        priceLabel.text = "Sarcoa"
        priceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        self.addSubview(priceLabel)
        
        let ln2 = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        let colorSpace2 = CGColorSpaceCreateDeviceRGB()
        let components2: [CGFloat] = [1.0, 135.0/255, 0.0, 1.0]
        let color2 = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(ln2, color)
        CGContextMoveToPoint(ln2, 40, 98)
        CGContextAddLineToPoint(ln2, 120, 98)
        CGContextStrokePath(ln2)
        
        var distanceLabel: UILabel = UILabel()
        distanceLabel.frame = CGRectMake(5, 103, 150, 15)
        distanceLabel.backgroundColor = UIColor.clearColor()
        distanceLabel.textColor = UIColor.whiteColor()
        distanceLabel.textAlignment = NSTextAlignment.Center
        distanceLabel.text = "9.69km"
        distanceLabel.font = distanceLabel.font.fontWithSize(10)
        self.addSubview(distanceLabel)
    }


}
