//
//  ExploreController.swift
//  BruhaMobile
//
//  Created by lye on 15/5/27.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {
    

    
    @IBOutlet weak var singlePageScroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singlePageScroll.contentSize.height = 1000

        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.setNavigationBarItem()
    }
    
    override func viewDidAppear(animated: Bool) {
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
