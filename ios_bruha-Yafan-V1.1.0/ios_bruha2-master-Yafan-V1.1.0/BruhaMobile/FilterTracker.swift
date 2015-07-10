//
//  FilterTracker.swift
//  BruhaMobile
//
//  Created by lye on 15/7/10.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import Foundation

enum FilterState: String {
    
    case Events = "events"
    case Venues = "venues"
    case Artists = "artists"
    case Organizations = "organizations"
}

class FilterTracker{
    
    static var currentFilter = FilterState.Events
}