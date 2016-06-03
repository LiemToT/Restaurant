//
//  DetailTableViewController.swift
//  RestaurantDemo
//
//  Created by linyi on 16/4/27.
//  Copyright © 2016年 linyi. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var restaurant : Restaurant!
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var ratingBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantImageView.image = UIImage(data: restaurant.image!)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        self.edgesForExtendedLayout = UIRectEdge.None
        
        title = restaurant.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DetailTableViewCell

        switch indexPath.row {
        case 0 :
            cell.fieldLabel.text = "店名"
            cell.valueLabel.text = restaurant.name
        case 1 :
            cell.fieldLabel.text = "类别"
            cell.valueLabel.text = restaurant.type
        case 2 :
            cell.fieldLabel.text = "地点"
            cell.valueLabel.text = restaurant.location
        case 3 :
            cell.fieldLabel.text = "是否来过"
            cell.valueLabel.text = restaurant.isVisited.boolValue ? "我来过了" : "我没来过"
        default :
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        if let imageName = restaurant.rating {
            ratingBtn.setImage(UIImage(named: imageName), forState: .Normal)
        }

        return cell
    }


    @IBAction func close(segue: UIStoryboardSegue) {
        if let reviewVC = segue.sourceViewController as? ReviewViewController {
            if let rating = reviewVC.rating {
                self.restaurant.rating = rating
                self.ratingBtn.setImage(UIImage(named: rating), forState: .Normal)
                
                let buffer = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
                
                do {
                    try buffer.save()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowMap" {
            let destVc = segue.destinationViewController as! MapViewController
            destVc.restaurant = restaurant
        }
    }

}
