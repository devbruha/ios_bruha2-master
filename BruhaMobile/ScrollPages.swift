//
//  ScrollPages.swift
//  
//
//  Created by lye on 15/5/21.
//
//

import UIKit

class ScrollPages: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        pageImages = [UIImage(named: "photo1.png")!,
            UIImage(named: "photo2.png")!,
            UIImage(named: "photo3.png")!,
            UIImage(named: "photo4.png")!,
            UIImage(named: "photo5.png")!]
        
        let pageCount = pageImages.count
        
        // 2
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        // 3
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // 4 Since you want a horizontal paging scroll view (it could just as easily be vertical if you want), you calculate the width to be the number of pages multiplied by the width of the scroll view. The height of the content is the same as the height of the scroll view.
        let pagesScrollViewSize = scrollView.frame.size
        //scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count),
        //  height: pagesScrollViewSize.height)
        scrollView.contentSize = CGSize(width:pagesScrollViewSize.width, height:pagesScrollViewSize.height * CGFloat(pageImages.count))
        
        // 5
        loadVisiblePages()
    }
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // 1
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            // 2 So first, work out the frame for this page. It’s calculated as being the same size as the scroll view, positioned at zero y offset, and then offset by the width of a page multiplied by the page number in the x (horizontal) direction.
            var frame = scrollView.bounds
            //frame.origin.x = frame.size.width * CGFloat(page)
            //frame.origin.y = 0.0
            frame.origin.x = 0.0
            frame.origin.y = frame.size.height * CGFloat(page)
            
            // 3
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            // 4
            pageViews[page] = newPageView
        }
    }
    func purgePage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    func loadVisiblePages() {
        // First, determine which page is currently visible
        //let pageWidth = scrollView.frame.size.width
        let pageHeight = scrollView.frame.size.height
        //let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        let page = Int(floor((scrollView.contentOffset.y * 2.0 + pageHeight) / (pageHeight * 2.0)))
        
        // Update the page control
        pageControl.currentPage = page
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // Load the pages that are now on screen
        loadVisiblePages()
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
