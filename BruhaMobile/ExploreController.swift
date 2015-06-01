//
//  ExploreController.swift
//  BruhaMobile
//
//  Created by lye on 15/5/27.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {
    

    @IBOutlet weak var exploreSubView: ExploreSubView!
    
    @IBOutlet weak var exploreSubView2: ExploreSubView!
    @IBOutlet var singlePageScroll: UIScrollView!
    var popUpView: ExplorePopUpViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singlePageScroll.contentSize.height = 1000
        
        //let mySubview:ExploreSubView = ExploreSubView(frame: CGRect(x:10, y:500, width:300, height:249))
        //self.view.addSubview(mySubview)
        //mySubview.view.backgroundColor = UIColor.whiteColor()
        //mySubview.titleLabel.text = "Third label!"
        
        exploreSubView.myButton.addTarget(self, action: "popPressed1:", forControlEvents: UIControlEvents.TouchUpInside)
        exploreSubView2.myButton.addTarget(self, action: "popPressed2:", forControlEvents: UIControlEvents.TouchUpInside)
        
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
    func popPressed1(sender: AnyObject) {
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        popUpView = storyboard.instantiateViewControllerWithIdentifier("ExplorePopUp") as! ExplorePopUpViewController
        self.addChildViewController(popUpView)
        self.exploreSubView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        self.exploreSubView2.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(1.0)
        popUpView.showInView(self.exploreSubView, animated: true)
        
            }
    func popPressed2(sender: AnyObject) {
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        popUpView = storyboard.instantiateViewControllerWithIdentifier("ExplorePopUp") as! ExplorePopUpViewController
        self.addChildViewController(popUpView)
        popUpView.showInView(self.exploreSubView2, animated: true)
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
