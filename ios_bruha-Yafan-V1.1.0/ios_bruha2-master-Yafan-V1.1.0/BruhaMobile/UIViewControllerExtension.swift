//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        //self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.addtopBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
        //self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removetopGestures()
        //self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addtopGestures()
    }
    
    func removeNavigationBarItem() {
        //self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
       // self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removetopGestures()
    }
}