//
//  AddItemsUIViewController.swift
//  MyMeals
//
//  Created by marceloalves on 11/02/23.
//

import UIKit

protocol AddItemsDelegate{
    func add(_ item: Item)
}

class AddItemsUIViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet
    weak var nameTextField: UITextField!
    
    @IBOutlet
    weak var caloriesTextField: UITextField!
    
    //MARK: - Atributos
    var delegate:AddItemsDelegate?
    
    init(delegate:AddItemsDelegate){
        super.init(nibName: "AddItemsUIViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = nil
    }
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBAction
    
    @IBAction
    func addItem(_ sender: Any) {
        
        guard let name = nameTextField.text , let calories = caloriesTextField.text else{
            return
        }
        
        if let numberCalories = Double(calories){
            let item = Item(name: name, calories: numberCalories)
            delegate?.add(item)
            navigationController?.popViewController(animated: true)
        }
    }
}
