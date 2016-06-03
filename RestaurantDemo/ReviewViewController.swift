//
//  ReviewViewController.swift
//  RestaurantDemo
//
//  Created by linyi on 16/5/4.
//  Copyright © 2016年 linyi. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    var rating: String?
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBAction func ratingBtnTapped(sender: UIButton) {
        switch sender.tag {
        case 100:
            rating = "dislike"
        case 200:
            rating = "good"
        case 300:
            rating = "great"
        default: break
        }
        
        performSegueWithIdentifier("UnwindToDetailView", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        effectView.frame = view.frame
        bgImageView.addSubview(effectView)
        
        let scale = CGAffineTransformMakeScale(0, 0)
        let transform = CGAffineTransformMakeTranslation(0, 500)
        
        ratingStackView.transform = CGAffineTransformConcat(scale, transform)
    }

    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                self.ratingStackView.transform = CGAffineTransformIdentity
            }, completion: nil)
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
