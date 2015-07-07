//
//  TicketViewController.swift
//  BruhaMobile
//
//  Created by lye on 15/7/3.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class TicketViewController: UIViewController,ARSPDragDelegate, ARSPVisibilityStateDelegate {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var bruha: UIButton!
    @IBAction func indexChange(sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            firstView.hidden = false
            secondView.hidden = true
        case 1:
            firstView.hidden = true
            secondView.hidden = false
        default:
            break;
        }
    }
    var panelControllerContainer: ARSPContainerController!
    
    func backTapped(){
        var storyboard = UIStoryboard(name:"Main",bundle:nil)
        self.performSegueWithIdentifier("BackBruha", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondView.hidden = true
        
        self.panelControllerContainer = self.parentViewController as! ARSPContainerController
        self.panelControllerContainer.dragDelegate = self
        self.panelControllerContainer.visibilityStateDelegate = self
        
        var tgr = UITapGestureRecognizer(target:self , action: Selector("backTapped"))
        bruha.addGestureRecognizer(tgr)
        bruha.userInteractionEnabled = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func panelControllerChangedVisibilityState(state:ARSPVisibilityState) {
        //TODO
        if(panelControllerContainer.shouldOverlapMainViewController){
            if (state.value == ARSPVisibilityStateMaximized.value) {
                self.panelControllerContainer.panelViewController.view.alpha = 1
            }else{
                self.panelControllerContainer.panelViewController.view.alpha = 0.9
            }
        }else{
            self.panelControllerContainer.panelViewController.view.alpha = 1
        }
    }
    
    func panelControllerWasDragged(panelControllerVisibility : CGFloat) {
        
    }
    
    
}
