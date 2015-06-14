//
//  CircleView.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-05.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    let tapRec = UITapGestureRecognizer()
    
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        UIColor.blueColor().colorWithAlphaComponent(0.5).setFill()
        path.fill()
    }
    


}
