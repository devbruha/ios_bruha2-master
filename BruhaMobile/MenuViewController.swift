//
//  MenuViewController.swift
//  BruhaMobile
//
//  Created by YUNFEI CUI on 2015-05-05.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex{
            case 0:
                break;
            case 1:
                self.performSegueWithIdentifier("GoToList", sender: self);
            case 2:
                self.performSegueWithIdentifier("GoToMap", sender: self);
            default:
                break;
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
