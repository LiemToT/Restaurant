//
//  RestaurantTableViewController.swift
//  RestaurantDemo
//
//  Created by linyi on 16/4/25.
//  Copyright © 2016年 linyi. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController , NSFetchedResultsControllerDelegate , UISearchResultsUpdating {

    
    var restaurants: [Restaurant] = []
    var sr: [Restaurant] = []
    var frc: NSFetchedResultsController!
    var sc: UISearchController!

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if var textToSearch = sc.searchBar.text {
            textToSearch = textToSearch.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            searchFilter(textToSearch)
            tableView.reloadData()
        }
    }
    
    func searchFilter(textToSearch: String) {
        sr = restaurants.filter({ (r) -> Bool in
            return r.name.containsString(textToSearch)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action:nil)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        let request = NSFetchRequest(entityName: "Restaurant")
        let sortDes = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDes]
        
        let buffer = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: buffer, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do {
            try frc.performFetch()
            restaurants = frc.fetchedObjects as! [Restaurant]
        } catch {
            print(error)
        }
        
        sc = UISearchController(searchResultsController: nil)
        sc.searchBar.searchBarStyle = .Default
        
        sc.dimsBackgroundDuringPresentation = false
        sc.searchResultsUpdater = self
        
        tableView.tableHeaderView = sc.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.boolForKey("GuideShowed") {
            return
        }
        
        if let pageVC = storyboard?.instantiateViewControllerWithIdentifier("GuideController") as? GuideViewController {
            presentViewController(pageVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sc.active ? sr.count : restaurants.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell

        let r = sc.active ? sr[indexPath.row] : restaurants[indexPath.row]
        
        cell.restaurantImage.image = UIImage(data: r.image!)
        cell.restaurantName.text = r.name
        cell.restaurantAddress.text = r.location
        cell.restaurantType.text = r.type
        
        cell.restaurantImage.layer.cornerRadius = cell.restaurantImage.frame.size.width / 2
        cell.restaurantImage.clipsToBounds = true
        cell.accessoryType = r.isVisited.boolValue ? .Checkmark : .None

        return cell
    }
    
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "亲,您选择了我", message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        
        let 拨打电话的处理 = { (alertAction: UIAlertAction) -> Void in
            let alert = UIAlertController(title: "提示", message: "您所拨打的电话无法接通", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        let dialAction = UIAlertAction(title: "拨打 021-6532\(indexPath.row)", style: .Default, handler: 拨打电话的处理)
        
        let title = self.收藏的餐馆[indexPath.row] ? "收藏" : "取消收藏"
        
        let 我来过 = UIAlertAction(title: title, style: .Default) { (_) -> Void in
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
            
            let result = title == "收藏" ? false : true
            cell.restaurantCollect.hidden = result
            self.收藏的餐馆[indexPath.row] = result
        }
        
        alert.addAction(cancelAction)
        alert.addAction(dialAction)
        alert.addAction(我来过)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    */
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return !sc.active
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            restaurants.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let 分享行为 = UITableViewRowAction(style: .Default, title: "分享") { (action, indexPath) -> Void in
            let alert = UIAlertController(title: "分享到", message: "请选择您要分享的社交类型", preferredStyle: .ActionSheet)
            
            let qqAction = UIAlertAction(title: "QQ", style: .Default, handler: nil)
            let wbAction = UIAlertAction(title: "微博", style: .Default, handler: nil)
            let wxAction = UIAlertAction(title: "微信", style: .Default, handler: nil)
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            
            alert.addAction(qqAction)
            alert.addAction(wbAction)
            alert.addAction(wxAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        let 删除行为 = UITableViewRowAction(style: .Default, title: "删除") { (action, indexPath) -> Void in
            
            let buffer = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            let restaurantToDel = self.frc.objectAtIndexPath(indexPath) as! Restaurant
            
            buffer.deleteObject(restaurantToDel)
            
            do {
               try buffer.save()
            } catch {
                print(error)
            }
        }
        
        return [分享行为, 删除行为]
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RestaurantDetailSegue" {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            
            let destin = segue.destinationViewController as! DetailTableViewController
            destin.restaurant = sc.active ? sr[selectedRow] : restaurants[selectedRow]
        }
    }
    
    @IBAction func unwindToHomePage(segue: UIStoryboardSegue) {

    }
    
    // MARK: - FetchController Delegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Automatic)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Automatic)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Automatic)
            }
        
        default:
            tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
}
















