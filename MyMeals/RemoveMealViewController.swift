//
//  RemoveMealViewController.swift
//  MyMeals
//
//  Created by marceloalves on 21/02/23.
//
import UIKit

class RemoveMealViewController{
    
    let controller:UIViewController
    
    init(controller:UIViewController){
        self.controller = controller
    }
    
    func show(_ meal:Meals, handler: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: .alert)
        let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(buttonCancel)
        let buttonRemove = UIAlertAction(title: "Remove", style: .destructive, handler: handler)
        alert.addAction(buttonRemove)
        controller.present(alert, animated: true, completion: nil)
    }
}
