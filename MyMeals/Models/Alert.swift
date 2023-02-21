//
//  Alert.swift
//  MyMeals
//
//  Created by marceloalves on 21/02/23.
//

import UIKit

class Alert{
    
    let controller:UIViewController
    
    init(controller:UIViewController){
        self.controller = controller
    }
    
    func show(title:String = "Attention", message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(buttonCancel)
        controller.present(alert, animated: true, completion: nil)
    }
}
