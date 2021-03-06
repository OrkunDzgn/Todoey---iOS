//
//  ViewController.swift
//  Todoey
//
//  Created by Orkun Düzgün on 1.02.2018.
//  Copyright © 2018 Orkun Duzgun. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let userDefaults = UserDefaults.standard

    //We didn't add IBOutlet for ListView because our class is a sublass of UITableViewController
    
    var itemArray = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Learn iOS"
        newItem.isDone = true
        
        let newItem2 = Item()
        newItem2.title = "Learn iOS"
        newItem2.isDone = false
        
        let newItem3 = Item()
        newItem3.title = "Learn iOS"
        newItem3.isDone = false
        
        itemArray.append(newItem)
        itemArray.append(newItem2)
        itemArray.append(newItem3)
        
        //if let items = userDefaults.array(forKey: "TodoListArray") as! [String] {
        //    itemArray = items
        //}
    }
    
    
    //MARK: Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        let tempItem = itemArray[indexPath.row]
        
        cell.textLabel?.text = tempItem.title
        
        if tempItem.isDone == true {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //mARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone //this line is same as if true then false else true etc.
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            //self.userDefaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Type new item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil )
        
    }

}

