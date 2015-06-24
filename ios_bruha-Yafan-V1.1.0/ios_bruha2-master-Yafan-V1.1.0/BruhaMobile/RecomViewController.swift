//
//  RecomViewController.swift
//  BruhaMobile
//
//  Created by lye on 15/6/24.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class RecomViewController: UITableViewController {

    var selectedIndexPath : NSIndexPath?
    
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
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RecomTableViewCell
        
        cell.titleLabel.layer.cornerRadius = 2.0
        cell.titleLabel.textColor = UIColor.whiteColor()
        cell.titleLabel.backgroundColor = UIColor.orangeColor()
        cell.titleLabel.text = "  Recommended"
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        }
        else{
            selectedIndexPath = indexPath
        }
        var indexPaths: Array<NSIndexPath> = []
        if let previous = previousIndexPath{
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! RecomTableViewCell).watchFrameChanges()
    }
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! RecomTableViewCell).ignoreFrameChanges()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return RecomTableViewCell.expandedHeight
        } else {
            return RecomTableViewCell.defaultHeight
        }
    }
    
    
    
}
