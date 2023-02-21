//
//  Item.swift
//  MyMeals
//
//  Created by marceloalves on 11/02/23.
//

import UIKit

class Item : NSObject, NSCoding{
    
    var name:String
    var calories:Double
    
    init(name:String, calories:Double){
        self.name = name
        self.calories = calories
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(calories, forKey: "calories")
    }
    
    required init?(coder aDecoder:NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        calories = aDecoder.decodeDouble(forKey: "calories")
    }
}
