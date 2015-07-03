//
//  TicketViewController.swift
//  BruhaMobile
//
//  Created by lye on 15/7/3.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class TicketViewController: UIViewController {

    @IBOutlet weak var segControl: UISegmentedControl!
    
    @IBAction func indexChange(sender: UISegmentedControl) {
        switch segControl.selectedSegmentIndex{
        case 0:
            break
        case 1:
            self.performSegueWithIdentifier("Bought", sender: self)
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
