//
//  VenuPanelViewController.swift
//  BruhaMobile
//
//  Created by lye on 15/6/23.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class VenuPanelViewController: UIViewController {

    @IBOutlet weak var eventsButton: UIButton!
    
    var panelControllerContainer: ARSPContainerController!
    var swipeZoneHeight: CGFloat = 30
    var visibleZoneHeight: CGFloat = 30
    
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    
    
    
    func transitToMenu(sender: UIScreenEdgePanGestureRecognizer){
        self.performSegueWithIdentifier("GoToMenu", sender: self)
    }
    func eventTapped(){
        var storyboard = UIStoryboard(name:"Main",bundle:nil)
        self.performSegueWithIdentifier("event", sender: self)
    }
    
    //  @IBOutlet weak var swipableZoneHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panelControllerContainer = self.parentViewController as! ARSPContainerController
        var tgr = UITapGestureRecognizer(target:self , action: Selector("eventTapped"))
        eventsButton.addGestureRecognizer(tgr)
        eventsButton.userInteractionEnabled = true
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "transitToMenu:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
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
