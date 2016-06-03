//
//  GuideViewController.swift
//  RestaurantDemo
//
//  Created by linyi on 16/5/7.
//  Copyright © 2016年 linyi. All rights reserved.
//

import UIKit

class GuideViewController: UIPageViewController , UIPageViewControllerDataSource {

    var headings = ["私人定制", "饕馆定位", "美食发现"]
    var images = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    var footers = ["好店随时加，打造自己的美食向导", "马上找到饕餮大餐之馆的位置", "发现其他吃货的珍藏"]
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! GuideContentViewController).index
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! GuideContentViewController).index
        
        index++
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> GuideContentViewController? {
        if case 0 ..< headings.count = index {
            if let contentVC = storyboard?.instantiateViewControllerWithIdentifier("GuideContentController") as? GuideContentViewController {
                contentVC.index = index
                contentVC.heading = headings[index]
                contentVC.footer = footers[index]
                contentVC.imageName = images[index]
                
                return contentVC
            }
        } else {
            return nil
        }
        
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        
        if let startingVC = viewControllerAtIndex(0) {
            setViewControllers([startingVC], direction: .Forward, animated: true, completion: nil)
        }
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
