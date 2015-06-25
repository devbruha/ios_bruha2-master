//
//  PriceView.swift
//  
//
//  Created by Ryan O'Neill on 2015-06-11.
//
//

import UIKit

@IBDesignable
class PriceView: UIView {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var shownPrice: UILabel!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    var view: UIView!
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        //m_table.dequeueReusableCellWithIdentifier("subCell")
        price.backgroundColor = UIColor.orangeColor()
        price.textColor = UIColor.whiteColor()
        price.text = "Admission Price"
        
        addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "PriceView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    @IBAction func slideValueChange(sender: UISlider) {
        var currentValue = Int(sender.value)
        
        shownPrice.text = "$\(currentValue)"
    }
    


}
