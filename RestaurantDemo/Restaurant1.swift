//
//  Restaurant.swift
//  RestaurantDemo
//
//  Created by linyi on 16/4/26.
//  Copyright © 2016年 linyi. All rights reserved.
//

import Foundation

struct Restaurant1 {
    var name : String
    var type : String
    var location : String
    var image : String
    var isVisited : Bool
    var rating = "rating"
    
    init(name : String, type : String, location : String, image : String, isVisited : Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
    }
}