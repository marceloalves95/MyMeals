//
//  ViewController.swift
//  MyMeals
//
//  Created by marceloalves on 29/01/23.
//

import UIKit

class MealTableViewController:UITableViewController,MainViewControllerDelegate {
    
    var meals:[Meals] = []
    
    override func viewDidLoad() {
        meals = MealDao().recover()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let meal = meals[indexPath.row]
        cell.textLabel?.text = meal.name
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails(_:)))
        cell.addGestureRecognizer(longPress)
        return cell
    }
    
    func add(_ meal:Meals){
        meals.append(meal)
        tableView.reloadData()
        MealDao().save(meals)
    }
    
    @objc func showDetails(_ gesture:UILongPressGestureRecognizer){
        if gesture.state == .began{
            let cell = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else{ return }
            let meal = meals[indexPath.row]
            
            func removeMeal(alert:UIAlertAction){
                print("Remover Refeição: \(meal.name)")
            }
            
            RemoveMealViewController(controller:self).show(meal, handler: { alert in
                self.meals.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar"{
            if let viewController = segue.destination as? MainViewController{
                viewController.delegate = self
            }
        }
    }
}

