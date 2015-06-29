//
//  ExploreController.swift
//  BruhaMobile
//
//  Created by lye on 15/5/27.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class ExploreController: UIViewController,ARSPDragDelegate, ARSPVisibilityStateDelegate {
    
    
    @IBOutlet weak var bruha: UIButton!
    @IBOutlet weak var events: UITableView!
    
    var panelControllerContainer: ARSPContainerController!
    
    //var counter:[Int] = []
    
   // let tapRec = UITapGestureRecognizer()

    
    var car = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg"]
    var carName = ["Lamborghini", "Drift", "Ferrari", "Hyundai","Mercedes Benz","Mitsubishi","Nissan","Volkswagen"]
    
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    
/*    func transitToMenu(sender: UIScreenEdgePanGestureRecognizer){
        self.performSegueWithIdentifier("GoToMenu", sender: self)
    }
*/
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
        
        
        //let mySubview:ExploreSubView = ExploreSubView(frame: CGRect(x:10, y:500, width:300, height:249))
        //self.view.addSubview(mySubview)
        //mySubview.view.backgroundColor = UIColor.whiteColor()
        //mySubview.titleLabel.text = "Third label!"
        
        var tgr = UITapGestureRecognizer(target:self , action: Selector("backTapped"))
        bruha.addGestureRecognizer(tgr)
        bruha.userInteractionEnabled = true
    /*
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "transitToMenu:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
    */    
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
        temp.sw_addUtilityButtonWithColor(UIColor.redColor(),title: "fadf")
        cell.leftUtilityButtons = temp as [AnyObject]
        return cell as EventsTableViewCell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        
        var firstAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "moreInfo" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
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
    /*func tappedView(sender:UITapGestureRecognizer){
        let tapAlert = UIAlertController(title: "Tapped", message: "You just tapped the rect view", preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)
        sender.view?.hidden = true

    }
    
    func tappedView2(sender:UITapGestureRecognizer){
        let tapAlert = UIAlertController(title: "Tapped", message: "You just tapped the circle view", preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)
        sender.view?.hidden = true
        
    }
*/

}
