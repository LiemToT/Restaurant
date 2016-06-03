//
//  Restaurant+CoreDataProperties.swift
//  RestaurantDemo
//
//  Created by linyi on 16/5/5.
//  Copyright © 2016年 linyi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Restaurant {

    @NSManaged var name: String
    @NSManaged var location: String
    @NSManaged var type: String
    @NSManaged var rating: String?
    @NSManaged var isVisited: NSNumber
    @NSManaged var image: NSData?

}
