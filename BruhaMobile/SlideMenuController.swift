//
//  SlideMenuController.swift
//
//  Created by Yuji Hato on 12/3/14.
//

import Foundation
import UIKit

struct SlideMenuOptions {
    //static var leftViewWidth: CGFloat = 270.0
    //static var leftBezelWidth: CGFloat = 16.0
    static var contentViewScale: CGFloat = 0.96
    static var contentViewOpacity: CGFloat = 0.5
    static var shadowOpacity: CGFloat = 0.0
    static var shadowRadius: CGFloat = 0.0
    static var shadowOffset: CGSize = CGSizeMake(0,0)
    static var panFromBezel: Bool = true
    static var animationDuration: CGFloat = 0.4
    static var bottomViewHeight: CGFloat = 300.0
    static var bottomBezelHeight: CGFloat = 60.0
    static var bottomPanFromBezel: Bool = true
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
    //var leftContainerView = UIView()
    var bottomContainerView =  UIView()
    var mainViewController: UIViewController?
    //var leftViewController: UIViewController?
    //var leftPanGesture: UIPanGestureRecognizer?
    //var leftTapGetsture: UITapGestureRecognizer?
    var bottomViewController: UIViewController?
    var bottomPanGesture: UIPanGestureRecognizer?
    var bottomTapGesture: UITapGestureRecognizer?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    /*convenience init(mainViewController: UIViewController, leftMenuViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        //leftViewController = leftMenuViewController
        initView()
    }*/
    
    convenience init(mainViewController: UIViewController, bottomMenuViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        bottomViewController = bottomMenuViewController
        initView()
    }
    
    //convenience init(mainViewController: UIViewController, leftMenuViewController: UIViewController, BottomMenuViewController: UIViewController) {
      //  self.init()
      //  self.mainViewController = mainViewController
        //leftViewController = leftMenuViewController
        //BottomViewController = BottomMenuViewController
     //   initView()
    //}
    
    deinit { }
    
    func initView() {
        mainContainerView = UIView(frame: view.bounds)
        mainContainerView.backgroundColor = UIColor.clearColor()
        mainContainerView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        view.insertSubview(mainContainerView, atIndex: 0)

        var opacityframe: CGRect = view.bounds
        var opacityOffset: CGFloat = 0
        opacityframe.origin.x = opacityframe.origin.x + opacityOffset
        opacityframe.size.width = opacityframe.size.width - opacityOffset
        opacityView = UIView(frame: opacityframe)
        opacityView.backgroundColor = UIColor.blackColor()
        opacityView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        opacityView.layer.opacity = 0.0
        view.insertSubview(opacityView, atIndex: 1)
        
        //var leftFrame: CGRect = view.bounds
        //leftFrame.size.Height = SlideMenuOptions.leftVieHeightw
        //leftFrame.origin.x = leftMinOrigin();
        //var leftOffset: CGFloat = 0
        //leftFrame.origin.y = leftFrame.origin.y + leftOffset
        //leftFrame.size.height = leftFrame.size.height - leftOffset
        //leftContainerView = UIView(frame: leftFrame)
        //leftContainerView.backgroundColor = UIColor.clearColor()
        //leftContainerView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        //view.insertSubview(leftContainerView, atIndex: 2)
        
        var bottomFrame: CGRect = view.bounds
        bottomFrame.size.height = SlideMenuOptions.bottomViewHeight
        bottomFrame.origin.y = bottomMinOrigin()
        var bottomOffset: CGFloat = 0
        bottomFrame.origin.x = bottomFrame.origin.x + bottomOffset;
        bottomFrame.size.width = bottomFrame.size.width - bottomOffset
        bottomContainerView = UIView(frame: bottomFrame)
        bottomContainerView.backgroundColor = UIColor.clearColor()
        bottomContainerView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        view.insertSubview(bottomContainerView, atIndex: 3)
        
        //addLeftGestures()
        addBottomGestures()
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        
        mainContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        //leftContainerView.hidden = true
        bottomContainerView.hidden = true
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
        
        //closeLeftNonAnimation()
        closeBottomNonAnimation()
        //leftContainerView.hidden = false
        bottomContainerView.hidden = true

        //removeLeftGestures()
        removeBottomGestures()
        //addLeftGestures()
        addBottomGestures()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func viewWillLayoutSubviews() {
        // topLayoutGuideの値が確定するこのタイミングで各種ViewControllerをセットする
        setUpViewController(mainContainerView, targetViewController: mainViewController)
        //setUpViewController(leftContainerView, targetViewController: leftViewController)
        setUpViewController(bottomContainerView, targetViewController: bottomViewController)
    }
    
    /*override func openLeft() {
        setOpenWindowLevel()
        
        //leftViewControllerのviewWillAppearを呼ぶため
        //leftViewController?.beginAppearanceTransition(isLeftHidden(), animated: true)
        //openLeftWithVelocity(0.0)
        
        track(.TapOpen)
    }*/
    
    override func openBottom() {
        setOpenWindowLevel()
        
        //menuViewControllerのviewWillAppearを呼ぶため
        bottomViewController?.beginAppearanceTransition(isBottomHidden(), animated: true)
        openBottomWithVelocity(0.0)
    }
    
    //override func closeLeft() {
    //    leftViewController?.beginAppearanceTransition(isLeftHidden(), animated: true)
    //    closeLeftWithVelocity(0.0)
    //    setCloseWindowLebel()
    //}
    
    override func closeBottom() {
        bottomViewController?.beginAppearanceTransition(isBottomHidden(), animated: true)
        closeBottomWithVelocity(0.0)
        setCloseWindowLebel()
    }
    
    
    //func addLeftGestures() {
    //
    //    if (leftViewController != nil) {
    //        if leftPanGesture == nil {
    //            leftPanGesture = UIPanGestureRecognizer(target: self, action: "handleLeftPanGesture:")
    //            leftPanGesture!.delegate = self
    //            view.addGestureRecognizer(leftPanGesture!)
    //        }
    //
    //        if leftTapGetsture == nil {
    //            leftTapGetsture = UITapGestureRecognizer(target: self, action: "toggleLeft")
    //            leftTapGetsture!.delegate = self
    //            view.addGestureRecognizer(leftTapGetsture!)
    //        }
    //    }
    //}
    
    func addBottomGestures() {
        
        if (bottomViewController != nil) {
            if bottomPanGesture == nil {
                bottomPanGesture = UIPanGestureRecognizer(target: self, action: "handleBottomPanGesture:")
                bottomPanGesture!.delegate = self
                view.addGestureRecognizer(bottomPanGesture!)
            }
            
            if bottomTapGesture == nil {
                bottomTapGesture = UITapGestureRecognizer(target: self, action: "toggleBottom")
                bottomTapGesture!.delegate = self
                view.addGestureRecognizer(bottomTapGesture!)
            }
        }
    }
    
    //func removeLeftGestures() {
        
    //    if leftPanGesture != nil {
    //        view.removeGestureRecognizer(leftPanGesture!)
    //        leftPanGesture = nil
    //    }
    //
    //    if leftTapGetsture != nil {
    //        view.removeGestureRecognizer(leftTapGetsture!)
    //       leftTapGetsture = nil
    //    }
    //}
    
    func removeBottomGestures() {
        
        if bottomPanGesture != nil {
            view.removeGestureRecognizer(bottomPanGesture!)
            bottomPanGesture = nil
        }
        
        if bottomTapGesture != nil {
            view.removeGestureRecognizer(bottomTapGesture!)
            bottomTapGesture = nil
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
    
    //struct LeftPanState {
    //    static var frameAtStartOfPan: CGRect = CGRectZero
    //    static var startPointOfPan: CGPoint = CGPointZero
    //    static var wasOpenAtStartOfPan: Bool = false
    //    static var wasHiddenAtStartOfPan: Bool = false
    //}
    
    //func handleLeftPanGesture(panGesture: UIPanGestureRecognizer) {
        
    //    if !isTagetViewController() {
    //        return
    //    }
    //
    //    if isRightOpen() {
    //        return
    //    }
        
    //    switch panGesture.state {
    //        case UIGestureRecognizerState.Began:
    //
    //            LeftPanState.frameAtStartOfPan = leftContainerView.frame
    //            LeftPanState.startPointOfPan = panGesture.locationInView(view)
    //            LeftPanState.wasOpenAtStartOfPan = isLeftOpen()
    //            LeftPanState.wasHiddenAtStartOfPan = isLeftHidden()
    //
    //            leftViewController?.beginAppearanceTransition(LeftPanState.wasHiddenAtStartOfPan, animated: true)
    //        addShadowToView(leftContainerView)
    //           setOpenWindowLevel()
    //        case UIGestureRecognizerState.Changed:
    //
    //            var translation: CGPoint = panGesture.translationInView(panGesture.view!)
    //            leftContainerView.frame = applyLeftTranslation(translation, toFrame: LeftPanState.frameAtStartOfPan)
    //            applyLeftOpacity()
    //            applyLeftContentViewScale()
    //        case UIGestureRecognizerState.Ended:
                
    //            var velocity:CGPoint = panGesture.velocityInView(panGesture.view)
    //            var panInfo: PanInfo = panLeftResultInfoForVelocity(velocity)
    //
    //            if panInfo.action == .Open {
    //                if !LeftPanState.wasHiddenAtStartOfPan {
    //                    leftViewController?.beginAppearanceTransition(true, animated: true)
    //                }
    //                openLeftWithVelocity(panInfo.velocity)
    //                track(.FlickOpen)
    //
    //           } else {
    //                if LeftPanState.wasHiddenAtStartOfPan {
    //                   leftViewController?.beginAppearanceTransition(false, animated: true)
    //                }
    //                closeLeftWithVelocity(panInfo.velocity)
    //                setCloseWindowLebel()
    //
    //                track(.FlickClose)

    //            }
    //    default:
    //        break
    //    }
    //
   // }
    
    struct BottomPanState {
        static var frameAtStartOfPan: CGRect = CGRectZero
        static var startPointOfPan: CGPoint = CGPointZero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
    }
    
    func handleBottomPanGesture(panGesture: UIPanGestureRecognizer) {
        
        if !isTagetViewController() {
            return
        }
        /*
        if isLeftOpen() {
            return
        }
        */
        switch panGesture.state {
        case UIGestureRecognizerState.Began:
            
            BottomPanState.frameAtStartOfPan = bottomContainerView.frame
            BottomPanState.startPointOfPan = panGesture.locationInView(view)
            BottomPanState.wasOpenAtStartOfPan =  isBottomOpen()
            BottomPanState.wasHiddenAtStartOfPan = isBottomHidden()
            
            bottomViewController?.beginAppearanceTransition(BottomPanState.wasHiddenAtStartOfPan, animated: true)
            addShadowToView(bottomContainerView)
            setOpenWindowLevel()
        case UIGestureRecognizerState.Changed:
            
            var translation: CGPoint = panGesture.translationInView(panGesture.view!)
            bottomContainerView.frame = applyBottomTranslation(translation, toFrame: BottomPanState.frameAtStartOfPan)
            applyBottomOpacity()
            applyBottomContentViewScale()
            
        case UIGestureRecognizerState.Ended:
            
            var velocity: CGPoint = panGesture.velocityInView(panGesture.view)
            var panInfo: PanInfo = panBottomResultInfoForVelocity(velocity)
            
            if panInfo.action == .Open {
                if !BottomPanState.wasHiddenAtStartOfPan {
                    bottomViewController?.beginAppearanceTransition(true, animated: true)
                }
                openBottomWithVelocity(panInfo.velocity)
            } else {
                if BottomPanState.wasHiddenAtStartOfPan {
                    bottomViewController?.beginAppearanceTransition(false, animated: true)
                }
                closeBottomWithVelocity(panInfo.velocity)
                setCloseWindowLebel()
            }
        default:
            break
        }
    }
    
    /*func openLeftWithVelocity(velocity: CGFloat) {
        var xOrigin: CGFloat = leftContainerView.frame.origin.x
        var finalXOrigin: CGFloat = 0.0
        
        var frame = leftContainerView.frame;
        frame.origin.x = finalXOrigin;
        
        var duration: NSTimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        addShadowToView(leftContainerView)
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.leftContainerView.frame = frame
                strongSelf.opacityView.layer.opacity = Float(SlideMenuOptions.contentViewOpacity)
                strongSelf.mainContainerView.transform = CGAffineTransformMakeScale(SlideMenuOptions.contentViewScale, SlideMenuOptions.contentViewScale)
            }
            }) { [weak self](Bool) -> Void in
                if let strongSelf = self {
                    strongSelf.disableContentInteraction()
                    strongSelf.leftViewController?.endAppearanceTransition()
                }
        }
    }
    */
    func openBottomWithVelocity(velocity: CGFloat) {
        var yOrigin: CGFloat = bottomContainerView.frame.origin.y
    
        //	CGFloat finalXOrigin = SlideMenuOptions.bottomViewOverlapHeight;
        var finalyOrigin: CGFloat = CGRectGetHeight(view.bounds) - bottomContainerView.frame.size.height
        
        var frame = bottomContainerView.frame
        frame.origin.y = finalyOrigin
    
        var duration: NSTimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(yOrigin - CGRectGetHeight(view.bounds)) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
    
        addShadowToView(bottomContainerView)
    
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.bottomContainerView.frame = frame
                strongSelf.opacityView.layer.opacity = Float(SlideMenuOptions.contentViewOpacity)
                strongSelf.mainContainerView.transform = CGAffineTransformMakeScale(SlideMenuOptions.contentViewScale, SlideMenuOptions.contentViewScale)
            }
            }) { [weak self](Bool) -> Void in
                if let strongSelf = self {
                    strongSelf.disableContentInteraction()
                    strongSelf.bottomViewController?.endAppearanceTransition()
                }
        }
    }
    
    /*func closeLeftWithVelocity(velocity: CGFloat) {
        
        var xOrigin: CGFloat = leftContainerView.frame.origin.x
        var finalXOrigin: CGFloat = leftMinOrigin()
        
        var frame: CGRect = leftContainerView.frame;
        frame.origin.x = finalXOrigin
    
        var duration: NSTimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.leftContainerView.frame = frame
                strongSelf.opacityView.layer.opacity = 0.0
                strongSelf.mainContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }
            }) { [weak self](Bool) -> Void in
                if let strongSelf = self {
                    strongSelf.removeShadow(strongSelf.leftContainerView)
                    strongSelf.enableContentInteraction()
                    strongSelf.leftViewController?.endAppearanceTransition()
                }
        }
    }*/
    
    
    func closeBottomWithVelocity(velocity: CGFloat) {
    
        var yOrigin: CGFloat = bottomContainerView.frame.origin.y
        var finalyOrigin: CGFloat = CGRectGetHeight(view.bounds)
    
        var frame: CGRect = bottomContainerView.frame
        frame.origin.y = finalyOrigin
    
        var duration: NSTimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(yOrigin - CGRectGetHeight(view.bounds)) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
    
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.bottomContainerView.frame = frame
                strongSelf.opacityView.layer.opacity = 0.0
                strongSelf.mainContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }
            }) { [weak self](Bool) -> Void in
                if let strongSelf = self {
                    strongSelf.removeShadow(strongSelf.bottomContainerView)
                    strongSelf.enableContentInteraction()
                    strongSelf.bottomViewController?.endAppearanceTransition()
                }
        }
    }
    
    
    /*override func toggleLeft() {
        if isLeftOpen() {
            closeLeft()
            setCloseWindowLebel()
            // closeMenuはメニュータップ時にも呼ばれるため、closeタップのトラッキングはここに入れる
            
            track(.TapClose)
        } else {
            openLeft()
        }
    }
    
    func isLeftOpen() -> Bool {
        return leftContainerView.frame.origin.x == 0.0
    }
    
    func isLeftHidden() -> Bool {
        return leftContainerView.frame.origin.x <= leftMinOrigin()
    }*/
    
    override func toggleBottom() {
        if isBottomOpen() {
            closeBottom()
            setCloseWindowLebel()
        } else {
            openBottom()
        }
    }
    
    func isBottomOpen() -> Bool {
        return bottomContainerView.frame.origin.y == CGRectGetHeight(view.bounds) - bottomContainerView.frame.size.height
    }
    
    func isBottomHidden() -> Bool {
        return bottomContainerView.frame.origin.y >= CGRectGetHeight(view.bounds)
    }
    
    func changeMainViewController(mainViewController: UIViewController,  close: Bool) {
        
        removeViewController(mainViewController)
        self.mainViewController = mainViewController
        setUpViewController(mainContainerView, targetViewController: mainViewController)
        if (close) {
            //closeLeft()
            closeBottom()
        }
    }
    
    /*func changeLeftViewController(leftViewController: UIViewController, closeLeft:Bool) {
        
        removeViewController(leftViewController)
        self.leftViewController = leftViewController
        setUpViewController(leftContainerView, targetViewController: leftViewController)
        if closeLeft {
            self.closeLeft()
        }
    }*/
    
    func changeBottomViewController(bottomViewController: UIViewController, closeBottom:Bool) {
        removeViewController(bottomViewController)
        self.bottomViewController = bottomViewController;
        setUpViewController(bottomContainerView, targetViewController: bottomViewController)
        if closeBottom {
            self.closeBottom()
        }
    }
    
    /*private func leftMinOrigin() -> CGFloat {
        return  -SlideMenuOptions.leftViewWidth
    }
    */
    private func bottomMinOrigin() -> CGFloat {
        return CGRectGetHeight(view.bounds)
    }
    
    /*
    private func panLeftResultInfoForVelocity(velocity: CGPoint) -> PanInfo {
        
        var thresholdVelocity: CGFloat = 1000.0
        var pointOfNoReturn: CGFloat = CGFloat(floor(leftMinOrigin())) + SlideMenuOptions.pointOfNoReturnWidth
        var leftOrigin: CGFloat = leftContainerView.frame.origin.x
        
        var panInfo: PanInfo = PanInfo(action: .Close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = leftOrigin <= pointOfNoReturn ? .Close : .Open;
        
        if velocity.x >= thresholdVelocity {
            panInfo.action = .Open
            panInfo.velocity = velocity.x
        } else if velocity.x <= (-1.0 * thresholdVelocity) {
            panInfo.action = .Close
            panInfo.velocity = velocity.x
        }
        
        return panInfo
    }*/
    
    private func panBottomResultInfoForVelocity(velocity: CGPoint) -> PanInfo {
        
        var thresholdVelocity: CGFloat = -1000.0
        var pointOfNoReturn: CGFloat = CGFloat(floor(CGRectGetHeight(view.bounds)) - SlideMenuOptions.pointOfNoReturnWidth)
        var bottomOrigin: CGFloat = bottomContainerView.frame.origin.y
        
        var panInfo: PanInfo = PanInfo(action: .Close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = bottomOrigin >= pointOfNoReturn ? .Close : .Open
        
        if velocity.y <= thresholdVelocity {
            panInfo.action = .Open
            panInfo.velocity = velocity.y
        } else if (velocity.y >= (-1.0 * thresholdVelocity)) {
            panInfo.action = .Close
            panInfo.velocity = velocity.y
        }
        
        return panInfo
    }
    /*
    private func applyLeftTranslation(translation: CGPoint, toFrame:CGRect) -> CGRect {
        
        var newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x
        
        var minOrigin: CGFloat = leftMinOrigin()
        var maxOrigin: CGFloat = 0.0
        var newFrame: CGRect = toFrame
        
        if newOrigin < minOrigin {
            newOrigin = minOrigin
        } else if newOrigin > maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }*/
    
    private func applyBottomTranslation(translation: CGPoint, toFrame: CGRect) -> CGRect {
        
        var  newOrigin: CGFloat = toFrame.origin.y
        newOrigin += translation.y
        
        var minOrigin: CGFloat = bottomMinOrigin()
        //        var maxOrigin: CGFloat = SlideMenuOptions.bottomViewOverlapWidth
        var maxOrigin: CGFloat = bottomMinOrigin() - bottomContainerView.frame.size.height
        var newFrame: CGRect = toFrame
        
        if newOrigin > minOrigin {
            newOrigin = minOrigin
        } else if newOrigin < maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.y = newOrigin
        return newFrame
    }
    
    /*private func getOpenedLeftRatio() -> CGFloat {
        
        var height: CGFloat = leftContainerView.frame.size.height
        var currentPosition: CGFloat = leftContainerView.frame.origin.x - leftMinOrigin()
        return currentPosition / height
    }*/
    
    private func getOpenedBottomRatio() -> CGFloat {
        
        var height: CGFloat = bottomContainerView.frame.size.height
        var currentPosition: CGFloat = bottomContainerView.frame.origin.y
        return -(currentPosition - CGRectGetHeight(view.bounds)) / height
    }
    /*
    private func applyLeftOpacity() {
        
        var openedLeftRatio: CGFloat = getOpenedLeftRatio()
        var opacity: CGFloat = SlideMenuOptions.contentViewOpacity * openedLeftRatio
        opacityView.layer.opacity = Float(opacity)
    }
    */
    
    private func applyBottomOpacity() {
        var openedBottomRatio: CGFloat = getOpenedBottomRatio()
        var opacity: CGFloat = SlideMenuOptions.contentViewOpacity * openedBottomRatio
        opacityView.layer.opacity = Float(opacity)
    }
    
    /*private func applyLeftContentViewScale() {
        var openedLeftRatio: CGFloat = getOpenedLeftRatio()
        var scale: CGFloat = 1.0 - ((1.0 - SlideMenuOptions.contentViewScale) * openedLeftRatio);
        mainContainerView.transform = CGAffineTransformMakeScale(scale, scale)
    }
    */
    private func applyBottomContentViewScale() {
        var openedBottomRatio: CGFloat = getOpenedBottomRatio()
        var scale: CGFloat = 1.0 - ((1.0 - SlideMenuOptions.contentViewScale) * openedBottomRatio)
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
    
    /*func closeLeftNonAnimation(){
        setCloseWindowLebel()
        var finalttOrigin: CGFloat = leftMinOrigin()
        var frame: CGRect = leftContainerView.frame;
        frame.origin.x = finalXOrigin
        leftContainerView.frame = frame
        opacityView.layer.opacity = 0.0
        mainContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        removeShadow(leftContainerView)
        enableContentInteraction()
    }*/
    
    func closeBottomNonAnimation(){
        setCloseWindowLebel()
        var finalyOrigin: CGFloat = CGRectGetHeight(view.bounds)
        var frame: CGRect = bottomContainerView.frame
        frame.origin.y = finalyOrigin
        bottomContainerView.frame = frame
        opacityView.layer.opacity = 0.0
        mainContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        removeShadow(bottomContainerView)
        enableContentInteraction()
    }
    
    //pragma mark – UIGestureRecognizerDelegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    
        var point: CGPoint = touch.locationInView(view)
        
        //if gestureRecognizer == leftPanGesture {
        //    return slideLeftForGestureRecognizer(gestureRecognizer, point: point)
        //} else 
        if gestureRecognizer == bottomPanGesture {
            return slideBottomViewForGestureRecognizer(gestureRecognizer, withTouchPoint: point)
        } //else if gestureRecognizer == leftTapGetsture {
        //    return isLeftOpen() && !isPointContainedWithinLeftRect(point)
        //} 
            else if gestureRecognizer == bottomTapGesture {
            return isBottomOpen() && !isPointContainedWithinBottomRect(point)
        }
        
        return true
    }
    
    /*private func slideLeftForGestureRecognizer( gesture: UIGestureRecognizer, point:CGPoint) -> Bool{
        return isLeftOpen() || SlideMenuOptions.panFromBezel && isLeftPointContainedWithinBezelRect(point)
    }
    
    private func isLeftPointContainedWithinBezelRect(point: CGPoint) -> Bool{
        var leftBezelRect: CGRect = CGRectZero
        var tempRect: CGRect = CGRectZero
        var bezelWidth: CGFloat = SlideMenuOptions.leftBezelWidth
        
        CGRectDivide(view.bounds, &leftBezelRect, &tempRect, bezelWidth, CGRectEdge.MinXEdge)
        return CGRectContainsPoint(leftBezelRect, point)
    }
    
    private func isPointContainedWithinLeftRect(point: CGPoint) -> Bool {
        return CGRectContainsPoint(leftContainerView.frame, point)
    }*/
    
    
    
    private func slideBottomViewForGestureRecognizer(gesture: UIGestureRecognizer, withTouchPoint point: CGPoint) -> Bool {
        return isBottomOpen() || SlideMenuOptions.bottomPanFromBezel && isBottomPointContainedWithinBezelRect(point)
    }
    
    private func isBottomPointContainedWithinBezelRect(point: CGPoint) -> Bool {
        var bottomBezelRect: CGRect = CGRectZero
        var tempRect: CGRect = CGRectZero
        //CGFloat bezelWidth = bottomContainerView.frame.size.width;
        var bezelHeight: CGFloat = CGRectGetHeight(view.bounds) - SlideMenuOptions.bottomBezelHeight
        
        CGRectDivide(view.bounds, &tempRect, &bottomBezelRect, bezelHeight, CGRectEdge.MinXEdge)
        
        return CGRectContainsPoint(bottomBezelRect, point)
    }
    
    private func isPointContainedWithinBottomRect(point: CGPoint) -> Bool {
        return CGRectContainsPoint(bottomContainerView.frame, point)
    }
    
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
    
    /*func addLeftBarButtonWithImage(buttonImage: UIImage) {
        var leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.Bordered, target: self, action: "toggleLeft")
        navigationItem.leftBarButtonItem = leftButton;
    }*/
    
    func addBottomBarButtonWithImage(buttonImage: UIImage) {
        var bottomButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.Bordered, target: self, action: "toggleBottom")
        navigationItem.rightBarButtonItem = bottomButton;
    }
    
    /*func toggleLeft() {
        slideMenuController()?.toggleLeft()
    }*/

    func toggleBottom() {
        slideMenuController()?.toggleBottom()
    }
    
    /*func openLeft() {
        slideMenuController()?.openLeft()
    }*/
    
    func openBottom() {
        slideMenuController()?.openBottom()    }
    
    /*func closeLeft() {
        slideMenuController()?.closeLeft()
    }*/
    
    func closeBottom() {
        slideMenuController()?.closeBottom()
    }
    
    // Please specify if you want menu gesuture give priority to than targetScrollView
    func addPriorityToMenuGesuture(targetScrollView: UIScrollView) {
        if let slideControlelr = slideMenuController() {
            let recognizers =  slideControlelr.view.gestureRecognizers
            for recognizer in recognizers as! [UIGestureRecognizer] {
                if recognizer is UIPanGestureRecognizer {
                    targetScrollView.panGestureRecognizer.requireGestureRecognizerToFail(recognizer)
                }
            }
        }
    }
}
