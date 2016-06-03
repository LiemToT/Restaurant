//
//  DiscoverTableViewController.swift
//  RestaurantDemo
//
//  Created by linyi on 16/5/15.
//  Copyright © 2016年 linyi. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController {

    var restaurants: [AVObject] = []
    
    @IBOutlet var spinnerView: UIActivityIndicatorView!
    
    func getRecordFromCloud() {
        let query = AVQuery(className: "Restaurant")
        query.cachePolicy = .CacheElseNetwork
        query.maxCacheAge = 60 * 2
        
        if query.hasCachedResult() {
            print("从缓存中读取")
        }
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            guard error == nil else {
                print(error.localizedDescription)
                self.spinnerView.stopAnimating()
                return
            }
            
            if let objects = objects as? [AVObject] {
                self.restaurants = objects
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.reloadData()
                    
                    self.spinnerView.stopAnimating()
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        spinnerView.hidesWhenStopped = true
        spinnerView.center = view.center
        view.addSubview(spinnerView)
        spinnerView.startAnimating()
        
        getRecordFromCloud()
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
        return restaurants.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let restaurant = restaurants[indexPath.row]
        
        cell.textLabel?.text = restaurant["name"] as? String
        
        cell.imageView?.image = UIImage(named: "photoalbum")
        
        if let imageFile = restaurant["image"] as? AVFile {
            imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
                guard error == nil else {
                    print(error.localizedDescription)
                    return
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    cell.imageView?.image = UIImage(data: data)
                })
            })
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
