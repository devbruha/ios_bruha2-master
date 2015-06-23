//
//  FilterPanelViewController.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-07.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import Foundation


class FilterPanelViewController: UIViewController{
    
    @IBOutlet weak var venu: UIButton!
    var panelControllerContainer: ARSPContainerController!
    var swipeZoneHeight: CGFloat = 30
    var visibleZoneHeight: CGFloat = 30

    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    
    
    
    func transitToMenu(sender: UIScreenEdgePanGestureRecognizer){
        self.performSegueWithIdentifier("GoToMenu", sender: self)
    }
    func venuTapped(){
        var storyboard = UIStoryboard(name:"Main",bundle:nil)
        self.performSegueWithIdentifier("venu", sender: self)
    }
    
    
  //  @IBOutlet weak var swipableZoneHeightConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panelControllerContainer = self.parentViewController as! ARSPContainerController
        var tgr = UITapGestureRecognizer(target:self , action: Selector("venuTapped"))
        venu.addGestureRecognizer(tgr)
        venu.userInteractionEnabled = true
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