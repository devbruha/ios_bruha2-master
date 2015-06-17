//
//  SlideMenuController.swift
//  BruhaMobile
//
//  Created by Ryan O'Neill on 2015-06-16.
//  Copyright (c) 2015 Bruha. All rights reserved.
//

import Foundation
import UIKit

struct SlideMenuOptions {
    static var contentViewScale: CGFloat = 0.96
    static var contentViewOpacity: CGFloat = 0.5
    static var shadowOpacity: CGFloat = 0.0
    static var shadowRadius: CGFloat = 0.0
    static var shadowOffset: CGSize = CGSizeMake(0,0)
    static var panFromBezel: Bool = true
    static var animationDuration: CGFloat = 0.4
    static var topViewWidth: CGFloat = 370.0
    static var topViewHeight: CGFloat = 200.0
    static var topBezelHeight: CGFloat = 360.0
    static var topPanFromBezel: Bool = true
    static var hideStatusBar: Bool = true
    static var pointOfNoReturnWidth: CGFloat = 44.0
}

class SlideMenuController: UIViewController, UIGestureRecognizerDelegate {
    
    enum SlideAction {
        case Open
        case Close
    }
    
    enum TrackAction {
        case TapOpen
        case TapClose
        case FlickOpen
        case FlickClose
    }
    
    
    struct PanInfo {
        var action: SlideAction
        var shouldBounce: Bool
        var velocity: CGFloat
    }
    
    var opacityView = UIView()
    var mainContainerView = UIView()
    var topContainerView =  UIView()
    var mainViewController: UIViewController?
    var topViewController: UIViewController?
    var topPanGesture: UIPanGestureRecognizer?
    var topTapGesture: UITapGestureRecognizer?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(mainViewController: UIViewController, topMenuViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        topViewController = topMenuViewController
        initView()
    }
    
    deinit { }
    
    func initView() {
        mainContainerView = UIView(frame: view.bounds)
        mainContainerView.backgroundColor = UIColor.clearColor()
        mainContainerView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        view.insertSubview(mainContainerView, atIndex: 0)
        
        var opacityframe: CGRect = view.bounds
        var opacityOffset: CGFloat = 0
        opacityframe.origin.x = opacityframe.origin.x + opacityOffset
        opacityframe.size.height = opacityframe.size.height - opacityOffset
        opacityView = UIView(frame: opacityframe)
        opacityView.backgroundColor = UIColor.blackColor()
        opacityView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        opacityView.layer.opacity = 0.0
        view.insertSubview(opacityView, atIndex: 1)
        
        var topFrame: CGRect = view.bounds
        topFrame.size.width = SlideMenuOptions.topViewWidth
        topFrame.origin.x = 0
        var topOffset: CGFloat = 500
        
        topFrame.origin.y = topMinOrigin()
        //topFrame.size.height = topFrame.size.height - topOffset
        topFrame.size.height = SlideMenuOptions.topViewHeight
        topContainerView = UIView(frame: topFrame)
        topContainerView.backgroundColor = UIColor.clearColor()
        
        view.insertSubview(topContainerView, atIndex: 2)
        
        addtopGestures()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        mainContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        topContainerView.hidden = true
        
        coordinator.animateAlongsideTransition(nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.closetopNonAnimation()
            self.topContainerView.hidden = false
            
            self.removetopGestures()
            self.addtopGestures()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func viewWillLayoutSubviews() {
        // topLayoutGuideの値が確定するこのタイミングで各種ViewControllerをセットする
        setUpViewController(mainContainerView, targetViewController: mainViewController)
        setUpViewController(topContainerView, targetViewController: topViewController)
    }
    
    
    override func opentop() {
        setOpenWindowLevel()
        
        //menuViewControllerのviewWillAppearを呼ぶため
        topViewController?.beginAppearanceTransition(istopHidden(), animated: true)
        opentopWithVelocity(0.0)
    }
    
    override func closetop() {
        topViewController?.beginAppearanceTransition(istopHidden(), animated: true)
        closetopWithVelocity(0.0)
        setCloseWindowLebel()
    }
    
    func addtopGestures() {
        
        if (topViewController != nil) {
            if topPanGesture == nil {
                topPanGesture = UIPanGestureRecognizer(target: self, action: "handletopPanGesture:")
                topPanGesture!.delegate = self
                view.addGestureRecognizer(topPanGesture!)
            }
            
            if topTapGesture == nil {
                topTapGesture = UITapGestureRecognizer(target: self, action: "toggletop")
                topTapGesture!.delegate = self
                view.addGestureRecognizer(topTapGesture!)
            }
        }
    }
    
    
    func removetopGestures() {
        
        if topPanGesture != nil {
            view.removeGestureRecognizer(topPanGesture!)
            topPanGesture = nil
        }
        
        if topTapGesture != nil {
            view.removeGestureRecognizer(topTapGesture!)
            topTapGesture = nil
        }
    }
    
    func isTagetViewController() -> Bool {
        // Function to determine the target ViewController
        // Please to override it if necessary
        return true
    }
    
    func track(trackAction: TrackAction) {
        // function is for tracking
        // Please to override it if necessary
    }
    
    
    
    struct topPanState {
        static var frameAtStartOfPan: CGRect = CGRectZero
        static var startPointOfPan: CGPoint = CGPointZero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
    }
    
    func handletopPanGesture(panGesture: UIPanGestureRecognizer) {
        
        if !isTagetViewController() {
            return
        }
        
        switch panGesture.state {
        case UIGestureRecognizerState.Began:
            
            topPanState.frameAtStartOfPan = topContainerView.frame
            topPanState.startPointOfPan = panGesture.locationInView(view)
            topPanState.wasOpenAtStartOfPan =  istopOpen()
            topPanState.wasHiddenAtStartOfPan = istopHidden()
            
            topViewController?.beginAppearanceTransition(topPanState.wasHiddenAtStartOfPan, animated: true)
            addShadowToView(topContainerView)
            setOpenWindowLevel()
        case UIGestureRecognizerState.Changed:
            
            var translation: CGPoint = panGesture.translationInView(panGesture.view!)
            topContainerView.frame = applytopTranslation(translation, toFrame: topPanState.frameAtStartOfPan)
            applytopOpacity()
            applytopContentViewScale()
            
        case UIGestureRecognizerState.Ended:
            
            var velocity: CGPoint = panGesture.velocityInView(panGesture.view)
            var panInfo: PanInfo = pantopResultInfoForVelocity(velocity)
            
            if panInfo.action == .Open {
                if !topPanState.wasHiddenAtStartOfPan {
                    topViewController?.beginAppearanceTransition(true, animated: true)
                }
                opentopWithVelocity(panInfo.velocity)
            } else {
                if topPanState.wasHiddenAtStartOfPan {
                    topViewController?.beginAppearanceTransition(false, animated: true)
                }
                closetopWithVelocity(panInfo.velocity)
                setCloseWindowLebel()
            }
        default:
            break
        }
    }
    
    
    func opentopWithVelocity(velocity: CGFloat) {
        var yOrigin: CGFloat = topContainerView.frame.origin.y
        
        //	CGFloat finalXOrigin = SlideMenuOptions.topViewOverlapWidth;
        var finalYOrigin: CGFloat = 0
        
        var frame = topContainerView.frame
        frame.origin.y = finalYOrigin
        
        var duration: NSTimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(yOrigin - CGRectGetHeight(view.bounds)) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        addShadowToView(topContainerView)
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.topContainerView.frame = frame
                strongSelf.opacityView.layer.opacity = Float(SlideMenuOptions.contentViewOpacity)
                strongSelf.mainContainerView.transform = CGAffineTransformMakeScale(SlideMenuOptions.contentViewScale, SlideMenuOptions.contentViewScale)
            }
            }) { [weak self](Bool) -> Void in
                if let strongSelf = self {
                    strongSelf.disableContentInteraction()
                    strongSelf.topViewController?.endAppearanceTransition()
                }
        }
    }
    
    
    func closetopWithVelocity(velocity: CGFloat) {
        
        var yOrigin: CGFloat = topContainerView.frame.origin.y
        var finalYOrigin: CGFloat = -CGRectGetHeight(view.bounds)
        
        var frame: CGRect = topContainerView.frame
        frame.origin.y = finalYOrigin
        
        var duration: NSTimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(yOrigin - CGRectGetWidth(view.bounds)) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.topContainerView.frame = frame
                strongSelf.opacityView.layer.opacity = 0.0
                strongSelf.mainContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }
            }) { [weak self](Bool) -> Void in
                if let strongSelf = self {
                    strongSelf.removeShadow(strongSelf.topContainerView)
                    strongSelf.enableContentInteraction()
                    strongSelf.topViewController?.endAppearanceTransition()
                }
        }
    }
    
    override func toggletop() {
        if istopOpen() {
            closetop()
            setCloseWindowLebel()
        } else {
            opentop()
        }
    }
    
    func istopOpen() -> Bool {
        return topContainerView.frame.origin.y == 0
    }
    
    func istopHidden() -> Bool {
        return topContainerView.frame.origin.y >= CGRectGetHeight(view.bounds)
    }
    
    func changeMainViewController(mainViewController: UIViewController,  close: Bool) {
        
        removeViewController(mainViewController)
        self.mainViewController = mainViewController
        setUpViewController(mainContainerView, targetViewController: mainViewController)
        if (close) {
            closetop()
        }
    }
    
    
    func changetopViewController(topViewController: UIViewController, closetop:Bool) {
        removeViewController(topViewController)
        self.topViewController = topViewController;
        setUpViewController(topContainerView, targetViewController: topViewController)
        if closetop {
            self.closetop()
        }
    }
    
    
    private func topMinOrigin() -> CGFloat {
        return -CGRectGetHeight(view.bounds)
    }
    
    
    
    
    private func pantopResultInfoForVelocity(velocity: CGPoint) -> PanInfo {
        
        var thresholdVelocity: CGFloat = -1000.0
        var pointOfNoReturn: CGFloat = CGFloat(floor(CGRectGetHeight(view.bounds)) - SlideMenuOptions.pointOfNoReturnWidth)
        var topOrigin: CGFloat = topContainerView.frame.origin.y
        
        var panInfo: PanInfo = PanInfo(action: .Close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = topOrigin >= pointOfNoReturn ? .Close : .Open
        
        if velocity.y <= thresholdVelocity {
            panInfo.action = .Open
            panInfo.velocity = velocity.y
        } else if (velocity.y >= (-1.0 * thresholdVelocity)) {
            panInfo.action = .Close
            panInfo.velocity = velocity.y
        }
        
        return panInfo
    }
    
    
    
    private func applytopTranslation(translation: CGPoint, toFrame: CGRect) -> CGRect {
        
        var  newOrigin: CGFloat = toFrame.origin.y
        newOrigin += translation.y
        
        var minOrigin: CGFloat = topMinOrigin()
        //var maxOrigin: CGFloat = SlideMenuOptions.topViewOverlapWidth
        //var maxOrigin: CGFloat = topMinOrigin() - topContainerView.frame.size.height
        var maxOrigin: CGFloat = 0
        var newFrame: CGRect = toFrame
        
        if newOrigin > minOrigin {
            newOrigin = minOrigin
        } else if newOrigin < maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.y = newOrigin
        return newFrame
    }
    
    
    
    private func getOpenedtopRatio() -> CGFloat {
        
        var height: CGFloat = topContainerView.frame.size.height
        var currentPosition: CGFloat = topContainerView.frame.origin.y
        return -(currentPosition - CGRectGetWidth(view.bounds)) / height
    }
    
    private func applytopOpacity() {
        var openedtopRatio: CGFloat = getOpenedtopRatio()
        var opacity: CGFloat = SlideMenuOptions.contentViewOpacity * openedtopRatio
        opacityView.layer.opacity = Float(opacity)
    }
    
    private func applytopContentViewScale() {
        var openedtopRatio: CGFloat = getOpenedtopRatio()
        var scale: CGFloat = 1.0 - ((1.0 - SlideMenuOptions.contentViewScale) * openedtopRatio)
        mainContainerView.transform = CGAffineTransformMakeScale(scale, scale)
    }
    
    private func addShadowToView(targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = false
        targetContainerView.layer.shadowOffset = SlideMenuOptions.shadowOffset
        targetContainerView.layer.shadowOpacity = Float(SlideMenuOptions.shadowOpacity)
        targetContainerView.layer.shadowRadius = SlideMenuOptions.shadowRadius
        targetContainerView.layer.shadowPath = UIBezierPath(rect: targetContainerView.bounds).CGPath
    }
    
    private func removeShadow(targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = true
        mainContainerView.layer.opacity = 1.0
    }
    
    private func removeContentOpacity() {
        opacityView.layer.opacity = 0.0
    }
    
    
    private func addContentOpacity() {
        opacityView.layer.opacity = Float(SlideMenuOptions.contentViewOpacity)
    }
    
    private func disableContentInteraction() {
        mainContainerView.userInteractionEnabled = false
    }
    
    private func enableContentInteraction() {
        mainContainerView.userInteractionEnabled = true
    }
    
    private func setOpenWindowLevel() {
        if (SlideMenuOptions.hideStatusBar) {
            dispatch_async(dispatch_get_main_queue(), {
                if let window = UIApplication.sharedApplication().keyWindow {
                    window.windowLevel = UIWindowLevelStatusBar + 1
                }
            })
        }
    }
    
    private func setCloseWindowLebel() {
        if (SlideMenuOptions.hideStatusBar) {
            dispatch_async(dispatch_get_main_queue(), {
                if let window = UIApplication.sharedApplication().keyWindow {
                    window.windowLevel = UIWindowLevelNormal
                }
            })
        }
    }
    
    private func setUpViewController(targetView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            addChildViewController(viewController)
            viewController.view.frame = targetView.bounds
            targetView.addSubview(viewController.view)
            viewController.didMoveToParentViewController(self)
        }
    }
    
    
    private func removeViewController(viewController: UIViewController?) {
        if let _viewController = viewController {
            _viewController.willMoveToParentViewController(nil)
            _viewController.view.removeFromSuperview()
            _viewController.removeFromParentViewController()
        }
    }
    
    
    func closetopNonAnimation(){
        setCloseWindowLebel()
        var finalYOrigin: CGFloat = CGRectGetHeight(view.bounds)
        var frame: CGRect = topContainerView.frame
        frame.origin.y = finalYOrigin
        topContainerView.frame = frame
        opacityView.layer.opacity = 0.0
        mainContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        removeShadow(topContainerView)
        enableContentInteraction()
    }
    
    /*func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    
    var point: CGPoint = touch.locationInView(view)
    
    if gestureRecognizer == topPanGesture {
    return slidetopViewForGestureRecognizer(gestureRecognizer, withTouchPoint: point)
    }
    else if gestureRecognizer == topTapGesture {
    return istopOpen() && !isPointContainedWithintopRect(point)
    }
    
    return true
    }
    
    private func slidetopViewForGestureRecognizer(gesture: UIGestureRecognizer, withTouchPoint point: CGPoint) -> Bool {
    return istopOpen() || SlideMenuOptions.topPanFromBezel && istopPointContainedWithinBezelRect(point)
    }*/
    
    /*private func istopPointContainedWithinBezelRect(point: CGPoint) -> Bool {
    var topBezelRect: CGRect = CGRectZero
    var tempRect: CGRect = CGRectZero
    //CGFloat bezelWidth = topContainerView.frame.size.width;
    var bezelHeight: CGFloat = -CGRectGetHeight(view.bounds) + SlideMenuOptions.topBezelHeight
    
    CGRectDivide(view.bounds, &tempRect, &topBezelRect, bezelHeight, CGRectEdge.MinXEdge)
    
    return CGRectContainsPoint(topBezelRect, point)
    }
    
    private func isPointContainedWithintopRect(point: CGPoint) -> Bool {
    return CGRectContainsPoint(topContainerView.frame, point)
    }*/
    
}


extension UIViewController {
    
    func slideMenuController() -> SlideMenuController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SlideMenuController {
                return viewController as? SlideMenuController
            }
            viewController = viewController?.parentViewController
        }
        return nil;
    }
    
    func addtopBarButtonWithImage(buttonImage: UIImage) {
        var topButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.Plain, target: self, action: "toggletop")
        navigationItem.rightBarButtonItem = topButton;
    }
    
    func toggletop() {
        slideMenuController()?.toggletop()
    }
    
    
    func opentop() {
        slideMenuController()?.opentop()    }
    
    func closetop() {
        slideMenuController()?.closetop()
    }
    
    // Please specify if you want menu gesuture give priority to than targetScrollView
    /*func addPriorityToMenuGesuture(targetScrollView: UIScrollView) {
    if let slideControlelr = slideMenuController() {
    let recognizers =  slideControlelr.view.gestureRecognizers
    for recognizer in recognizers as! [UIGestureRecognizer] {
    if recognizer is UIPanGestureRecognizer {
    targetScrollView.panGestureRecognizer.requireGestureRecognizerToFail(recognizer)
    }
    }
    }
    }*/
}
