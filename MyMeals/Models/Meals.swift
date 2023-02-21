//
//  Meals.swift
//  MyMeals
//
//  Created by marceloalves on 04/02/23.
//

import UIKit

class Meals : NSObject, NSCoding{
    
    let name:String
    let happiness:Int
    var items:Array<Item> = []
    
    init(name:String, happiness:Int, items:[Item] = []){
        self.name = name
        self.happiness = happiness
        self.items = items
    }
    
    func details() -> String{
        var message = "Happiness: \(happiness)"
        for item in items{
            message += ",\(item.name) - calories: \(item.calories)"
        }
        return message
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(happiness, forKey: "happiness")
        aCoder.encode(items, forKey: "items")
    }
    
    required init?(coder aDecoder:NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        happiness = aDecoder.decodeInteger(forKey: "happiness")
        items = aDecoder.decodeObject(forKey: "items") as! Array<Item>
    }
}
