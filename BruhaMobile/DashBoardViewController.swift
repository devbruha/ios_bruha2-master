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
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("ExplorePopUp") as! ExplorePopUpViewController
        
        
        let rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
        
        let exploreController = storyboard.instantiateViewControllerWithIdentifier("ExploreController") as! ExploreController
        
        let slideMenuController = SlideMenuController(mainViewController: exploreController, rightMenuViewController: rightViewController)
        
        
        self.presentViewController(slideMenuController, animated: false, completion: nil)
        
        self.performSegueWithIdentifier("ExploreDetails", sender: self)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tgr = UITapGestureRecognizer(target:self , action: Selector("imageTapped"))
        ExploreImageView.addGestureRecognizer(tgr)
        ExploreImageView.userInteractionEnabled = true
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
