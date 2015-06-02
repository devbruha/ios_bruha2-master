//
//  ExploreController.swift
//  BruhaMobile
//
//  Created by lye on 15/5/27.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {
    
    
    @IBOutlet weak var events: UITableView!

    var popUpView: ExplorePopUpViewController!
    
    var car = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg"]
    var carName = ["Lamborghini", "Drift", "Ferrari", "Hyundai","Mercedes Benz","Mitsubishi","Nissan","Volkswagen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIScreen.mainScreen().bounds.size.height>768
        {
            events?.rowHeight=300;
        }
        
        //let mySubview:ExploreSubView = ExploreSubView(frame: CGRect(x:10, y:500, width:300, height:249))
        //self.view.addSubview(mySubview)
        //mySubview.view.backgroundColor = UIColor.whiteColor()
        //mySubview.titleLabel.text = "Third label!"
        
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
        return cell as EventsTableViewCell
        
        
        return cell
    }
    /*func popPressed1(sender: AnyObject) {
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        popUpView = storyboard.instantiateViewControllerWithIdentifier("ExplorePopUp") as! ExplorePopUpViewController
        self.addChildViewController(popUpView)
        self.exploreSubView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        self.exploreSubView2.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(1.0)
        popUpView.showInView(self.exploreSubView, animated: true)
        
            }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
