//
//  FilterPanelViewController.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-07.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import Foundation


class FilterPanelViewController: UIViewController,CalendarViewDelegate{
    
    @IBOutlet weak var RecomTable: UITableView!
    @IBOutlet weak var venu: UIButton!
    @IBOutlet weak var placeholderView: UIView!
    
    var panelControllerContainer: ARSPContainerController!
    var swipeZoneHeight: CGFloat = 30
    var visibleZoneHeight: CGFloat = 30

    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    
    
    
    func transitToMenu(sender: UIScreenEdgePanGestureRecognizer){
        self.performSegueWithIdentifier("GoToMenu", sender: self)
    }
    func venueTapped(){
        var storyboard = UIStoryboard(name:"Main",bundle:nil)
        self.performSegueWithIdentifier("venue", sender: self)
    }
    
    
  //  @IBOutlet weak var swipableZoneHeightConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panelControllerContainer = self.parentViewController as! ARSPContainerController
        var tgr = UITapGestureRecognizer(target:self , action: Selector("venueTapped"))
        venu.addGestureRecognizer(tgr)
        venu.userInteractionEnabled = true
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "transitToMenu:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
        
        let date = NSDate()
        
        // create an instance of calendar view with
        // base date (Calendar shows 12 months range from current base date)
        // selected date (marked dated in the calendar)
        let calendarView = CalendarView.instance(date, selectedDate: date)
        calendarView.delegate = self
        calendarView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        placeholderView.addSubview(calendarView)
        
        
        // Constraints for calendar view - Fill the parent view.
        placeholderView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[calendarView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["calendarView": calendarView]))
        placeholderView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[calendarView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["calendarView": calendarView]))

    }
    func didSelectDate(date: NSDate) {
        println("\(date.year)-\(date.month)-\(date.day)")
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.swipeZoneHeight = self.panelControllerContainer.swipableZoneHeight
        self.visibleZoneHeight = self.panelControllerContainer.visibleZoneHeight
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var selectedIndexPath : NSIndexPath?
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FilterPanelViewCell
        
        cell.titleLabel.layer.cornerRadius = 2.0
        //cell.titleLabel.textColor = UIColor.whiteColor()
        cell.titleLabel.backgroundColor = UIColor.orangeColor()
        //cell.titleLabel.text = "  Recommended"
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! FilterPanelViewCell).watchFrameChanges()
    }
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! FilterPanelViewCell).ignoreFrameChanges()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return FilterPanelViewCell.expandedHeight
        } else {
            return FilterPanelViewCell.defaultHeight
        }
    }

    

    
}