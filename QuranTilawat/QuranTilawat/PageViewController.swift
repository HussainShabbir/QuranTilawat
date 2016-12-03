//
//  PageViewController.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 10/27/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dataSource = self
        for index in 0...1 {
            setViewControllers([getViewControllerAtIndex(index: index)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        var vwController: UIViewController?
        if let idx = index, index != 0 {
            index = idx - 1
            if let index = index {
                vwController = getViewControllerAtIndex(index: index)
            }
        }
        return vwController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        var vwController: UIViewController?
        if let idx = index, idx < 1 {
            index = idx + 1
            if let index = index {
                vwController = getViewControllerAtIndex(index: index)
            }
        }
        return vwController
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> PageContentViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let pageContentViewController = storyBoard.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }
    
}
