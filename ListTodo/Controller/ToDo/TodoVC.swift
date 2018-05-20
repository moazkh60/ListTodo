//
//  TodoVC.swift
//  ListTodo
//
//  Created by Muhammad Moaz Khan on 16/03/2018.
//  Copyright © 2018 MK. All rights reserved.
//

import UIKit
import CoreData

class TodoVC: UITableViewController {
    
    // Items list to store todos
    var todoList: [ToDo] = []
    
    // Core data context
    var context: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // context from app delegate singleton
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        // load todo list data
        loadData()
    }
    
    // When add button on top is pressed
    @IBAction func addTodoPressed(_ sender: Any) {
        
        var itemTextField = UITextField()
        let alert = UIAlertController(title: "Add Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
            

            // Context can't be nil
            if let context = self.context{
                let todo = ToDo(context: context)
                let title = itemTextField.text
                
                // Nil todos can't be added
                if let title = title{
                    todo.title = title
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
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // Load data from  coredata
    func loadData(){
        let request:NSFetchRequest<ToDo> = ToDo.fetchRequest()
        do{
            if let context = context{
                todoList = try context.fetch(request)
                tableView.reloadData()
            }
        }catch{
            print("Error fetching data")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegueId"{
            let detailVC = segue.destination as? DetailVC
            if let detailVC = detailVC{
                //detailVC.text = todoList.text
            }
        }
    }
}

// MARK: - Extension for tableview methods
extension TodoVC{
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoItemCell
        cell.title.text = todoList[indexPath.item].title
        return cell
    }
}
