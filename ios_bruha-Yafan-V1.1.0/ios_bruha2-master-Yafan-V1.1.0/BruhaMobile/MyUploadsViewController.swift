//
//  MyUploadsViewController.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-17.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

class MyUploadsViewController: UIViewController,ARSPDragDelegate, ARSPVisibilityStateDelegate,SWTableViewCellDelegate {
    
    @IBOutlet weak var bruha: UIButton!
    @IBOutlet weak var myUploadTable: UITableView!
    
    var panelControllerContainer: ARSPContainerController!
    var car = ["1.jpg","2.jpg","3.jpg"]
    var carName = ["Lamborghini", "Drift", "Ferrari"]
    
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    
    func backTapped(){
        var storyboard = UIStoryboard(name:"Main",bundle:nil)
        self.performSegueWithIdentifier("BackBruha", sender: self)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.panelControllerContainer = self.parentViewController as! ARSPContainerController
        self.panelControllerContainer.dragDelegate = self
        self.panelControllerContainer.visibilityStateDelegate = self
        
        var tgr = UITapGestureRecognizer(target:self , action: Selector("backTapped"))
        bruha.addGestureRecognizer(tgr)
        bruha.userInteractionEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return car.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : MyUploadsCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as! MyUploadsCell!
        
        // Configure the cell...
        
        if(cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! MyUploadsCell;
        }
        let stringTitle = carName[indexPath.row] as String //NOT NSString
        let strCarName = car[indexPath.row] as String
        //cell.lblTitle.text=stringTitle
        cell.uploadImage.image = UIImage(named: strCarName)
        cell.uploadLabel.text = stringTitle
        
        var temp: NSMutableArray = NSMutableArray()
        temp.sw_addUtilityButtonWithColor(UIColor.redColor(),title: "Delete")
        cell.leftUtilityButtons = temp as [AnyObject]
        
        var temp2: NSMutableArray = NSMutableArray()
        temp2.sw_addUtilityButtonWithColor(UIColor.purpleColor(), title: "Status")
        cell.rightUtilityButtons = nil
        cell.rightUtilityButtons = temp2 as [AnyObject]
        
        cell.delegate = self


        return cell as MyUploadsCell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow();
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! MyUploadsCell;
        currentCell.tappedView();
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.None
        
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
    func swipeableTableViewCell( cell : SWTableViewCell!,didTriggerLeftUtilityButtonWithIndex index:NSInteger){
        
        switch(index){
        case 0:
            break
        case 1:
            // Delete button was pressed
            /*NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            [_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];*/
            //NSIndexPath.editingStyle = .Delete(cell)
            self.delete(self)
            break
        default:
            break
        }
    }
    
    func swipeableTableViewCell( cell : SWTableViewCell!,didTriggerRightUtilityButtonWithIndex index:NSInteger){
        switch(index){
        case 0:
            //Preview
            break
        case 1:
            //Status
            break
        //case 2:
            //More info
            //self.performSegueWithIdentifier("GoToMoreInfo", sender: self)
            //break
        default:
            break
        }
        
    }

    


}
