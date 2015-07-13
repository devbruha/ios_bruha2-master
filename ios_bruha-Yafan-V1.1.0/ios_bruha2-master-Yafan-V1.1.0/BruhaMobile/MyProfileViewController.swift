//
//  MyProfileViewController.swift
//  BruhaMobile
//
//  Created by lye on 15/7/13.
//  Copyright (c) 2015年 Bruha. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var myInfo: UIView!
    @IBOutlet weak var myImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImage.layer.borderWidth = 1
        myImage.layer.masksToBounds = false
        myImage.layer.borderColor = UIColor.blackColor().CGColor
        myImage.layer.cornerRadius = myImage.frame.height/2
        myImage.clipsToBounds = true
        myImage.image = UIImage(named: "1.png")
        
        name.text = "Ryan O'Neill"
        /*userName.text = "rrrryan"
        age.text = "3456"
        sex.text = "F"
        location.text = "Toronto Ontario Canada"*/
        

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
