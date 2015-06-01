//
//  ExploreController.swift
//  BruhaMobile
//
//  Created by lye on 15/5/27.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {
    

    
    @IBOutlet var singlePageScroll: UIScrollView!
    var popUpView: ExplorePopUpViewController!
    
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
    
    @IBAction func popPressed(sender: AnyObject) {
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        popUpView = storyboard.instantiateViewControllerWithIdentifier("ExplorePopUp") as! ExplorePopUpViewController
        self.addChildViewController(popUpView)
        popUpView.showInView(self.view , animated: true)
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
