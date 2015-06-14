//
//  RectView.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-05.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

@IBDesignable
class RectView: UIView{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(rect: rect)
        UIColor.yellowColor().colorWithAlphaComponent(0.4).setFill()
        path.fill()
    }

}
