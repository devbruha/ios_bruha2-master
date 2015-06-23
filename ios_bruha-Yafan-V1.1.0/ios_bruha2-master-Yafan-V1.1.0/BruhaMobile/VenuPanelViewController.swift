//
//  VenuPanelViewController.swift
//  BruhaMobile
//
//  Created by lye on 15/6/23.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class VenuPanelViewController: UIViewController {

    var panelControllerContainer: ARSPContainerController!
    var swipeZoneHeight: CGFloat = 30
    var visibleZoneHeight: CGFloat = 30
    
    
    //  @IBOutlet weak var swipableZoneHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panelControllerContainer = self.parentViewController as! ARSPContainerController
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.swipeZoneHeight = self.panelControllerContainer.swipableZoneHeight
        self.visibleZoneHeight = self.panelControllerContainer.visibleZoneHeight
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
