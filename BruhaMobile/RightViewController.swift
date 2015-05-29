//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

class RightViewController : UIViewController {
   
    @IBOutlet weak var buyTicket: UIButton!
    @IBOutlet weak var preview: UIButton!
    @IBOutlet weak var moreInfo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        buyTicket.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        preview.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        moreInfo.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        buyTicket.frame = CGRectMake(20, 50, 50, 100)
        buyTicket.layoutMargins.bottom = 10
        buyTicket.layoutMargins.top = 500
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
