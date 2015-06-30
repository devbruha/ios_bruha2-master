//
//  MoreInfoViewController.swift
//  BruhaMobile
//
//  Created by YUNFEI CUI on 2015-05-07.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {

    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var ticketTop: UIView!
    @IBOutlet weak var ticketBottom: UIView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var venu: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var subs: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var remaining: UILabel!
    @IBOutlet weak var end: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var total: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ticketTop.layer.cornerRadius = 8.0
        ticketBottom.layer.cornerRadius = 8.0
        payButton.layer.cornerRadius = 8.0
        
        eventTitle.text = "Kentucky Derby Festival"
        price.text = "15.00"
        age.text = "19+"
        time.text = "1:00pm"
        date.text = "July 27th, 2015"
        quantity.text = "3"
        var dbl = (price.text as! NSString).doubleValue * (quantity.text as! NSString).doubleValue
        var tot = dbl
        total.text = "$\(tot)"

        
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
