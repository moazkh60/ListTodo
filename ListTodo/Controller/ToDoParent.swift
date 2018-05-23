//
//  TodoParent.swift
//  ListTodo
//
//  Created by Muhammad Moaz Khan on 23/05/2018.
//  Copyright © 2018 MK. All rights reserved.
//

import UIKit
import CoreData

class ToDoParent: UIViewController {

    // Items list to store todos
    public var todoList: [ToDo] = []
    
    // Core data context
    public var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Load data from  coredata
    public func loadData()->Bool{
        let request:NSFetchRequest<ToDo> = ToDo.fetchRequest()
        do{
            if let context = context{
                todoList = try context.fetch(request)
                return true
            }
        }catch{
            print("Error fetching data")
        }
        return false
    }
}
