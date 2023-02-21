//
//  ItemDao.swift
//  MyMeals
//
//  Created by marceloalves on 21/02/23.
//

import Foundation

class ItemDao{
    
    func save(_ items:[Item]){
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
            guard let directory = recoverDiretory() else { return }
            try data.write(to: directory)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recoverDiretory() -> URL?{
        guard let diretory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let path = diretory.appendingPathExtension("items")
        return path
    }
    
    func recover() -> [Item]{
        do{
            guard let directory = recoverDiretory() else { return []}
            let data = try Data(contentsOf: directory)
            let itemsSave = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Item]
            return itemsSave
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
