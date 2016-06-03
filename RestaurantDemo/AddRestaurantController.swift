//
//  AddRestaurantController.swift
//  RestaurantDemo
//
//  Created by linyi on 16/5/5.
//  Copyright © 2016年 linyi. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantController: UITableViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    var restaurant: Restaurant!
    var restaurant1 = [
        Restaurant1(name: "咖啡胡同", type: "咖啡 & 茶店", location: "香港上环德辅道西78号G/F", image: "cafedeadend.jpg", isVisited: false) ,
        Restaurant1(name: "霍米", type: "咖啡", location: "香港上环文咸东街太平山22-24A，B店", image: "homei.jpg", isVisited: false) ,
        Restaurant1(name: "茶.家", type: "茶屋", location: "香港葵涌和宜合道熟食市场地下", image: "teakha.jpg", isVisited: false) ,
        Restaurant1(name: "洛伊斯咖啡", type: "奥地利式 & 休闲饮料", location: "香港新界葵涌屏富径", image: "cafeloisl.jpg", isVisited: false) ,
        Restaurant1(name: "贝蒂生蚝", type: "法式", location: "香港九龙尖沙咀河内道18号(近港铁尖东站N3,N4出口) ", image: "petiteoyster.jpg", isVisited: false) ,
        Restaurant1(name: "福奇餐馆", type: "面包房", location: "香港岛中环都爹利街13号乐成行地库中层", image: "forkeerestaurant.jpg", isVisited: false) ,
        Restaurant1(name: "阿波画室", type: "面包房", location: "香港岛铜锣湾轩尼诗道555号崇光百货地库2楼30号铺", image: "posatelier.jpg", isVisited: false) ,
        Restaurant1(name: "伯克街面包坊", type: "巧克力", location: "4 Hickson Rd、The Rocks NSW 2000", image: "bourkestreetbakery.jpg", isVisited: false) ,
        Restaurant1(name: "黑氏巧克力", type: "咖啡", location: "31 Wheat Rd、Sydney NSW 2001", image: "haighschocolate.jpg", isVisited: false) ,
        Restaurant1(name: "惠灵顿雪梨", type: "美式 & 海鲜", location: "1/11-31 York Street Sydney NSW Australia、Sydney NSW 2000", image: "palominoespresso.jpg", isVisited: false) ,
        Restaurant1(name: "北州", type: "美式", location: "Macy's、151 W 34th St Fifth Floor、New York, NY 10001", image: "upstate.jpg", isVisited: false) ,
        Restaurant1(name: "布鲁克林塔菲", type: "美式", location: "250 8th Ave、New York, NY 10107", image: "traif.jpg", isVisited: false) ,
        Restaurant1(name: "格雷厄姆大街肉", type: "早餐 & 早午餐", location: "55-1 Riverwalk Pl、West New York, NJ 07093", image: "grahamavenuemeats.jpg", isVisited: false) ,
        Restaurant1(name: "华夫饼 & 沃夫", type: "法式 & 茶", location: "1585 Broadway、New York, NY 10036-8200", image: "wafflewolf.jpg", isVisited: false) ,
        Restaurant1(name: "五叶", type: "咖啡 & 茶", location: "1460 Broadway、New York, NY 10036", image: "fiveleaves.jpg", isVisited: false) ,
        Restaurant1(name: "眼光咖啡", type: "拉丁美式", location: "250 8th Ave、New York, NY 10107", image: "cafelore.jpg", isVisited: false) ,
        Restaurant1(name: "忏悔", type: "西班牙式", location: "822 Lexington Ave、New York, NY 10065", image: "confessional.jpg", isVisited: false) ,
        Restaurant1(name: "巴拉菲娜", type: "西班牙式", location: "Unit 2, Eldon Chambers、30-32 Fleet St、London EC4Y 1AA", image: "barrafina.jpg", isVisited: false) ,
        Restaurant1(name: "多尼西亚", type: "西班牙式", location: "Waterloo Station、London SE1 7LY", image: "donostia.jpg", isVisited: false) ,
        Restaurant1(name: "皇家橡树", type: "英式", location: "Unit 4a、44-58 Brompton Rd、London SW3 1BW", image: "royaloak.jpg", isVisited: false) ,
        Restaurant1(name: "泰咖啡", type: "泰式", location: "7-9 Golders Green Rd、London NW11 8DY", image: "thaicafe.jpg", isVisited: false)]
    
    var isVisited = false
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelVisited: UILabel!
    
    @IBAction func isVisitedBtnTapped(sender: UIButton) {
        if sender.tag == 8001 {
            isVisited = true
            labelVisited.text = "我来过了"
        } else {
            isVisited = false
            labelVisited.text = "我没来过"
        }
    }
    
    @IBAction func saveBtnTapped(sender: UIBarButtonItem) {
        
//        while(restaurant1.count != 0)
//        {
//            let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
//            
//            restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: buffer!) as! Restaurant
//            restaurant.name = restaurant1[0].name
//            restaurant.type = restaurant1[0].type
//            restaurant.location = restaurant1[0].location
//            restaurant.image = UIImagePNGRepresentation(UIImage(named: restaurant1[0].image)!)
//            restaurant.isVisited = isVisited
//            
//            restaurant1.removeFirst()
//            
//            do {
//                try  buffer?.save()
//            } catch {
//                print(error)
//            }
//        }
        
        
        let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        
        restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: buffer!) as! Restaurant
        restaurant.name = name.text!
        restaurant.type = type.text!
        restaurant.location = location.text!
        if let image = imageView.image {
            restaurant.image = UIImagePNGRepresentation(image)
        }
        restaurant.isVisited = isVisited
        
        do {
            try  buffer?.save()
        } catch {
            print(error)
        }
        
        saveRecordToCloud(restaurant)
        
        performSegueWithIdentifier("unwindToHomeList", sender: sender)
    }
    
    func saveRecordToCloud(restaurant: Restaurant) {
        let record = AVObject(className: "Restaurant")
        
        record["name"] = restaurant.name
        record["type"] = restaurant.type
        record["location"] = restaurant.location
        
        let originImg = UIImage(data: restaurant.image!)!
        let scalingFac = originImg.size.width > 1024 ? 1024 /  originImg.size.width : 1.0
        let scaledImg = UIImage(data: restaurant.image!, scale: scalingFac)!
        
        let imgFile = AVFile.fileWithName("\(restaurant.name).jpg", data: UIImageJPEGRepresentation(scaledImg, 0.8))
        record["image"] = imgFile
        
        record.saveInBackgroundWithBlock { (_, error) -> Void in
            guard error == nil else {
                print(error.localizedDescription)
                return
            }
            
            print("保存成功")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.endEditing(true)
        
        if indexPath.row == 0 {
            let alert = UIAlertController(title: "获取图片", message: "", preferredStyle: .ActionSheet)
            
            let handle = { (action: UIAlertAction!) -> Void in
                var sourceType : UIImagePickerControllerSourceType!
                
                if action.title == "从图库中获取" {
                    sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                } else if action.title == "拍照" {
                    sourceType = UIImagePickerControllerSourceType.Camera
                }
                
                if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                    let picker = UIImagePickerController()
                    picker.delegate = self
                    picker.sourceType = sourceType
                    picker.allowsEditing = false
                    
                    self.presentViewController(picker, animated: true, completion: nil)
                }
            }
            
            let libraryAction = UIAlertAction(title: "从图库中获取", style: .Default, handler: handle)
            let photoAction = UIAlertAction(title: "拍照", style: .Default, handler: handle)
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            
            alert.addAction(libraryAction)
            alert.addAction(photoAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        let leftCons = NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: imageView.superview, attribute: .Leading, multiplier: 1, constant: 0)
        let rightCons = NSLayoutConstraint(item: imageView, attribute: .Trailing, relatedBy: .Equal, toItem: imageView.superview, attribute: .Trailing, multiplier: 1, constant: 0)
        let topCons = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: imageView.superview, attribute: .Top, multiplier: 1, constant: 0)
        let bottomCons = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: imageView.superview, attribute: .Bottom, multiplier: 1, constant: 0)
        
        leftCons.active = true
        rightCons.active = true
        topCons.active = true
        bottomCons.active = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
