//
//  MainViewController.swift
//  MyMeals
//
//  Created by marceloalves on 04/02/23.
//

import UIKit

protocol MainViewControllerDelegate{
    func add(_ meal:Meals)
}

class MainViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, AddItemsDelegate{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    //MARK: - Atributos
    var delegate:MainViewControllerDelegate?
    var items:[Item] = []
    var itemsSelected:[Item] = []
    
    //MARK: - @IBOutlets
    @IBOutlet
    var mealNameTextField: UITextField?
    
    @IBOutlet
    var happinessTextField: UITextField?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        let buttonAddItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = buttonAddItem
        recoverItems()
    }
    
    func recoverItems(){
        items = ItemDao().recover()
    }
    
    @objc func addItem(){
        let addItemsViewController = AddItemsUIViewController(delegate:self)
        navigationController?.pushViewController(addItemsViewController, animated: true)
    }
    
    func retrieveMealFromForm() -> Meals?{
        guard let nameMeal = mealNameTextField?.text else{ return nil}
        guard let mealHappiness = happinessTextField?.text, let happiness = Int(mealHappiness) else{ return nil}
        let meal = Meals(name: nameMeal, happiness: happiness, items: itemsSelected)
        return meal
    }
    
    //MARK: - @IBActions
    @IBAction
    func addMeal(_ sender: Any) {
        if let meal = retrieveMealFromForm(){
            delegate?.add(meal)
            navigationController?.popViewController(animated: true)
        }else{
            Alert(controller: self).show(message: "Error read data field")
        }
    }
    
    func add(_ item: Item) {
        items.append(item)
        ItemDao().save(items)
        itemsTableView.reloadData()
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let lineOfTable = indexPath.row
        
        let item = items[lineOfTable]
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        if cell.accessoryType == .none{
            cell.accessoryType = .checkmark
            let lineOfTable = indexPath.row
            itemsSelected.append(items[lineOfTable])
        } else{
            cell.accessoryType = .none
            let item = items[indexPath.row]
            if let position = itemsSelected.firstIndex(of: item){
                itemsSelected.remove(at: position)
            }
        }
    }
}
