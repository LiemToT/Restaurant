//
//  GuideContentViewController.swift
//  RestaurantDemo
//
//  Created by linyi on 16/5/7.
//  Copyright © 2016年 linyi. All rights reserved.
//

import UIKit

class GuideContentViewController: UIViewController {
    
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var labelFooter: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!

    var index = 0
    var heading = ""
    var footer = ""
    var imageName = ""
    
    @IBAction func tapToSkip(sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setBool(true, forKey: "GuideShowed")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = index

        if index == 2 {
            skipButton.hidden = false
        } else {
            skipButton.hidden = true
        }
        
        // Do any additional setup after loading the view.
        labelHeading.text = heading
        labelFooter.text = footer
        imageView.image = UIImage(named: imageName)
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
