//
//  CalendarViewController.swift
//  BruhaMobile
//
//  Created by lye on 15/6/30.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController,CalendarViewDelegate {

    @IBOutlet var placeholderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // todays date.
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

}
