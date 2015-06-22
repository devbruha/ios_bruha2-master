//
//  TopViewController.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-16.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var dropDown: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIScreen.mainScreen().bounds.size.height>768
        {
            dropDown?.rowHeight=300;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var eventName = ["Hamilton Bull Dogs", "Drift", "Ferrari", "Hyundai","Mercedes Benz","Mitsubishi","Nissan","Volkswagen"]
    var price = ["$15.0","$200.0","Free","$5.0","$799.9","Free","Free","Free"]
    var image = ["1.jpg","1.jpg","1.jpg","1.jpg","1.jpg","1.jpg","1.jpg","1.jpg"]
    var location = ["First Ontario Place","First Ontario Place","First Ontario Place","First Ontario Place","First Ontario Place","First Ontario Place","First Ontario Place","First Ontario Place"]
    var address = ["123 Bay Street North","123 Bay Street North","123 Bay Street North","123 Bay Street North","123 Bay Street North","123 Bay Street North","123 Bay Street North","123 Bay Street North"]
    var city = ["Hamilton, ON","Hamilton, ON","Hamilton, ON","Hamilton, ON","Hamilton, ON","Hamilton, ON","Hamilton, ON","Hamilton, ON"]
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return eventName.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : DropDownTableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as! DropDownTableViewCell!
        
        // Configure the cell...
        
        if(cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! DropDownTableViewCell;
        }
        let stringTitle = eventName[indexPath.row] as String //NOT NSString
        let stringPrice = price[indexPath.row] as String
        let strImage = image[indexPath.row] as String
        let strLocation = location[indexPath.row] as String
        let strAddress = address[indexPath.row] as String
        let strCity = city[indexPath.row] as String
        
        //cell.lblTitle.text=stringTitle
        
        cell.titleLabel.text = stringTitle
        cell.priceLabel.text = stringPrice
        cell.eventImage.image = UIImage(named:strImage)
        cell.locationLabel.text = strLocation
        cell.adressLabel.text = strAddress
        cell.cityLabel.text = strCity
        cell.timeLabel.text = "Friday, May 15, 2015 at 7:00pm"
        return cell as DropDownTableViewCell
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
    
    
    
}
