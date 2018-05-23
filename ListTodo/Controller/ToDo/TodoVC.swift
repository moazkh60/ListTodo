//
//  TodoVC.swift
//  ListTodo
//
//  Created by Muhammad Moaz Khan on 16/03/2018.
//  Copyright © 2018 MK. All rights reserved.
//

import UIKit
import CoreData

class ToDoVC: ToDoParent{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // context from app delegate singleton
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        // load todo list data
        if loadData(){
            tableView.reloadData()
        }
    }
    
    // When add button on top is pressed
    @IBAction func addTodoPressed(_ sender: Any) {
        
        var itemTextField = UITextField()
        var detailsTextField = UITextField()
        
        let alert = UIAlertController(title: "Add Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
            

            // Context can't be nil
            if let context = self.context{
                let todo = ToDo(context: context)
                let title = itemTextField.text
                let details = detailsTextField.text
                
                // Nil todos can't be added
                if let title = title{
                    todo.title = title
                    todo.detail = details
                    
                    self.todoList.append(todo)
                    
                    do{
                        try context.save()
                        self.tableView.reloadData()
                    }catch{
                        fatalError("Error storing data")
                    }
                }
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add Todo Item"
            itemTextField = textField
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add Todo Details"
            detailsTextField = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func loadData()->Bool{
        if super.loadData(){
            return true
        }
        return false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegueId"{
            let detailVC = segue.destination as? DetailVC
            let row = sender as? Int
            if let detailVC = detailVC, let row = row{
                detailVC.titleText = todoList[row].title
                detailVC.detailText = todoList[row].detail
            }
        }
    }
}

// MARK: - Extension for tableview methods
extension ToDoVC: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoItemCell
        cell.title.text = todoList[indexPath.item].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegueId", sender: indexPath.row)
    }
}
