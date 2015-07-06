//
//  SoldTableViewController.swift
//  BruhaMobile
//
//  Created by lye on 15/7/6.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class SoldTableViewController: UITableViewController {

    @IBOutlet var soldTableView: UITableView!
    var car = ["4.jpg","6.jpg","2.jpg","7.jpg"]
    var carName = ["Lamborghini","WOWOWO", "Ferrari","HAHAHA"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return car.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : SoldTableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as! SoldTableViewCell!
        
        // Configure the cell...
        
        if(cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! SoldTableViewCell;
        }
        let stringTitle = carName[indexPath.row] as String //NOT NSString
        let strCarName = car[indexPath.row] as String
        //cell.lblTitle.text=stringTitle
        cell.picture.image = UIImage(named: strCarName)
        cell.titleLabel.text = stringTitle
        return cell as SoldTableViewCell
    }

}
