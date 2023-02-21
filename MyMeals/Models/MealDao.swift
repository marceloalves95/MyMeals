//
//  MealDao.swift
//  MyMeals
//
//  Created by marceloalves on 21/02/23.
//

import Foundation

class MealDao{
    
    func save(_ meal:[Meals]){
        guard let path = recoverPath() else { return }
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: meal, requiringSecureCoding: false)
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recoverPath() -> URL?{
        guard let diretory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let path = diretory.appendingPathComponent("meal")
        return path
    }
    
    func recover() -> [Meals]{
        guard let path = recoverPath() else { return []}
        do{
            let data = try Data(contentsOf: path)
            guard let mealSave = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Meals> else { return []}
            return mealSave
        } catch{
            print(error.localizedDescription)
            return []
        }
    }
}
