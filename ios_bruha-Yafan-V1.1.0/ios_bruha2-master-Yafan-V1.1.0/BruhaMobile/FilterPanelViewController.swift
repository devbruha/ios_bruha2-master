//
//  FilterPanelViewController.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-07.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import Foundation


class FilterPanelViewController: UIViewController{
    
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