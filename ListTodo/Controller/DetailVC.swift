//
//  DetailVC.swift
//  ListTodo
//
//  Created by Muhammad Moaz Khan on 16/03/2018.
//  Copyright © 2018 MK. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController {

    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var detailItem: UINavigationItem!
    
    // Todo title
    var titleText: String?
    
    // Todo detail
    var detailText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailItem.prompt = titleText
        
        //set the detail text
        detailTextView.text = detailText
        
    }
}
