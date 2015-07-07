//
//  ExploreController.swift
//  BruhaMobile
//
//  Created by lye on 15/5/27.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class ExploreController: UIViewController,ARSPDragDelegate, ARSPVisibilityStateDelegate, SWTableViewCellDelegate {
    
    
    @IBOutlet weak var bruha: UIButton!
    @IBOutlet weak var events: UITableView!
    
    var panelControllerContainer: ARSPContainerController!
    
    //var counter:[Int] = []
    
   // let tapRec = UITapGestureRecognizer()

    
    var car = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg"]
    var carName = ["Lamborghini", "Drift", "Ferrari", "Hyundai","Mercedes Benz","Mitsubishi","Nissan","Volkswagen"]
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    

    func backTapped(){
        var storyboard = UIStoryboard(name:"Main",bundle:nil)
        self.performSegueWithIdentifier("BackBruha", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIScreen.mainScreen().bounds.size.height>768
        {
            events?.rowHeight=300;
        }
        
        self.panelControllerContainer = self.parentViewController as! ARSPContainerController
        self.panelControllerContainer.dragDelegate = self
        self.panelControllerContainer.visibilityStateDelegate = self
        self.events!.allowsMultipleSelection = false
        
        var tgr = UITapGestureRecognizer(target:self , action: Selector("backTapped"))
        bruha.addGestureRecognizer(tgr)
        bruha.userInteractionEnabled = true
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        var cell : EventsTableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as! EventsTableViewCell!
        
        // Configure the cell...
        
        if(cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! EventsTableViewCell;
        }
        let stringTitle = carName[indexPath.row] as String //NOT NSString
        let strCarName = car[indexPath.row] as String
        //cell.lblTitle.text=stringTitle
        cell.eventImage.image = UIImage(named: strCarName)
        cell.eventTitle.text = stringTitle

        //cell.rightUtilityButtons =
        var temp: NSMutableArray = NSMutableArray()
        temp.sw_addUtilityButtonWithColor(UIColor.redColor(),title: "Get Hyped")
        cell.leftUtilityButtons = temp as [AnyObject]

        
        var temp2: NSMutableArray = NSMutableArray()
        temp2.sw_addUtilityButtonWithColor(UIColor.purpleColor(), title: "Buy Tickets")
        temp2.sw_addUtilityButtonWithColor(UIColor.grayColor(), title: "Preview")
        temp2.sw_addUtilityButtonWithColor(UIColor.orangeColor(), title: "More Info")
        cell.rightUtilityButtons = nil
        cell.rightUtilityButtons = temp2 as [AnyObject]
        
        cell.delegate = self
        cell.selectionStyle = .None
        
        return cell as EventsTableViewCell
        
    }
    

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow();
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! EventsTableViewCell;
        currentCell.tappedView();
        tableView.deselectRowAtIndexPath(indexPath!, animated: false)
    }
    
  
  
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {

        return UITableViewCellEditingStyle.None
        
    }
    
    /*
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        
        var firstAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "moreInfo" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            /*let rateMenu = UIAlertController(title: nil, message: "Rate this App", preferredStyle: .ActionSheet)
            self.presentViewController(rateMenu, animated: true, completion: nil)*/
                    })
        
        firstAction.backgroundColor = UIColor.orangeColor()
        
        var secondAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Preview" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                    })
        secondAction.backgroundColor = UIColor.grayColor()
        
        var thirdAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Buy Tickets" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
        })
        thirdAction.backgroundColor = UIColor.purpleColor()

      
        return [firstAction,secondAction,thirdAction]
    }
    */
    //for slider dragging
    
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

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
        func swipeableTableViewCell( cell : SWTableViewCell!,didTriggerLeftUtilityButtonWithIndex index:NSInteger){
        
        switch(index){
            case 0:
                break
            case 1:
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
            //Ticket
                break
            case 2:
            //More info
                self.performSegueWithIdentifier("GoToMoreInfo", sender: self)
                break
            default:
                break
        }
        
    }

}
