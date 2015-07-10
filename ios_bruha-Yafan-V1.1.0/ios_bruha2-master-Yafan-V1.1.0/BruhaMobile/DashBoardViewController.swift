//
//  ListViewController.swift
//  BruhaMobile
//
//  Created by YUNFEI CUI on 2015-05-05.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {


    @IBOutlet weak var ExploreImageView: UIImageView!
    
    @IBOutlet weak var MyUploadsImageView: UIImageView!
    
    @IBOutlet weak var MyAddicImageView: UIImageView!
    
    @IBOutlet weak var MyTicketsImageView: UIImageView!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            self.performSegueWithIdentifier("GoToMenu", sender: self)
            break
        case 1:
            break
        case 2:
            self.performSegueWithIdentifier("GoToMap", sender: self)
            break
        default:
            break
        }
    }
    
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!

    
    
    func transitToMenu(sender: UIScreenEdgePanGestureRecognizer){
        self.performSegueWithIdentifier("GoToMenu", sender: self)
    }
    
    
    func imageTapped(){

        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        /*let mainViewController = storyboard.instantiateViewControllerWithIdentifier("explorePopUp") as! ExplorePopUpTableViewController
        
        
        let rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
        
        let exploreController = storyboard.instantiateViewControllerWithIdentifier("ExploreController") as! ExploreController
        
        let slideMenuController = SlideMenuController(mainViewController: exploreController, rightMenuViewController: rightViewController)
        
        
        self.presentViewController(slideMenuController, animated: false, completion: nil)*/
        
        //if( FilterTracker.currentFilter == FilterState.Events){
            
            self.performSegueWithIdentifier("ExploreDetails", sender: self)
        //}
        //else if(FilterTracker.currentFilter == FilterState.Venues){
            
          //  self.performSegueWithIdentifier("venue", sender: self)
        //}
        
    }
    
    func uploadTapped(){
        var storyboard = UIStoryboard(name:"Main",bundle:nil)
        self.performSegueWithIdentifier("MyUploadsImageView", sender: self)
    }
    
    func addictionTapped(){
        var storyboard = UIStoryboard(name:"Main",bundle:nil)
        self.performSegueWithIdentifier("MyAddicImageView", sender: self)

    }
    
    func ticketsTapped(){
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.performSegueWithIdentifier("myTicket", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tgr = UITapGestureRecognizer(target:self , action: Selector("imageTapped"))
        ExploreImageView.addGestureRecognizer(tgr)
        ExploreImageView.userInteractionEnabled = true
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "transitToMenu:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
        
        var tgr2 = UITapGestureRecognizer(target: self, action: Selector("ticketsTapped"))
        MyTicketsImageView.addGestureRecognizer(tgr2)
        MyTicketsImageView.userInteractionEnabled = true
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "transitToMenu:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
        
        var tgr3 = UITapGestureRecognizer(target: self, action: Selector("uploadTapped"))
        MyUploadsImageView.addGestureRecognizer(tgr3)
        MyUploadsImageView.userInteractionEnabled = true
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "transitToMenu:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
        
        var tgr4 = UITapGestureRecognizer(target: self, action: Selector("addictionTapped"))
        MyAddicImageView.addGestureRecognizer(tgr4)
        MyAddicImageView.userInteractionEnabled = true
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "transitToMenu:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)


        // Do any additional setup after loading the view.

    }
    

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "GoToMenu"){
            if let destinationVC = segue.destinationViewController as? MapViewController{
                
            }
        }
    }
*/    

}
