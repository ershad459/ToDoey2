//
//  ViewController.swift
//  ToDoey2
//
//  Created by Ershad Ilkhan on 7/7/19.
//  Copyright © 2019 Ershad Ilkhan. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {

    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "h"
        itemArray.append(newItem)
        
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {

           itemArray = items
    }
        
        
    }

    
    // tableView data source methods.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListItem", for: indexPath)
        
        
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        return cell
        
    }
    
    // table view delegate methods.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            
            // what will happen once the user clicks the add item button on our UIAlert.
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    

}

