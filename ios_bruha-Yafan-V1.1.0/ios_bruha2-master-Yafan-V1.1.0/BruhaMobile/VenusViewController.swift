//
//  VenusViewController.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-19.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import UIKit

class VenusViewController: UIViewController,ARSPDragDelegate, ARSPVisibilityStateDelegate{

    @IBOutlet weak var bruha: UIButton!
    @IBOutlet weak var venuTable: UITableView!
    
    var car = ["7.jpg","8.jpg"]
    var carName = ["Nissan","Volkswagen"]
    
    var panelControllerContainer: ARSPContainerController!
    
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    
    func transitToMenu(sender: UIScreenEdgePanGestureRecognizer){
        self.performSegueWithIdentifier("GoToMenu", sender: self)
    }
    
    func backTapped(){
        var storyboard = UIStoryboard(name:"Main",bundle:nil)
        self.performSegueWithIdentifier("BackBruha", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panelControllerContainer = self.parentViewController as! ARSPContainerController
        self.panelControllerContainer.dragDelegate = self
        self.panelControllerContainer.visibilityStateDelegate = self

        // Do any additional setup after loading the view.
        var tgr = UITapGestureRecognizer(target:self , action: Selector("backTapped"))
        bruha.addGestureRecognizer(tgr)
        bruha.userInteractionEnabled = true
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "transitToMenu:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return car.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : VenuTableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as! VenuTableViewCell!
        
        // Configure the cell...
        
        if(cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! VenuTableViewCell;
        }
        let stringTitle = carName[indexPath.row] as String //NOT NSString
        let strCarName = car[indexPath.row] as String
        //cell.lblTitle.text=stringTitle
        cell.venuImage.image = UIImage(named: strCarName)
        cell.venuLabel.text = stringTitle
        return cell as VenuTableViewCell
    }
    func panelControllerChangedVisibilityState(state:ARSPVisibilityState) {
        //TODO
        if(panelControllerContainer.shouldOverlapMainViewController){
            if (state.value == ARSPVisibilityStateMaximized.value) {
                self.panelControllerContainer.panelViewController.view.alpha = 1
            }else{
                self.panelControllerContainer.panelViewController.view.alpha = 0.9
            }
        }else{
            self.panelControllerContainer.panelViewController.view.alpha = 1
        }
    }
    
    func panelControllerWasDragged(panelControllerVisibility : CGFloat) {
        
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
