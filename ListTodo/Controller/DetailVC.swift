//
//  DetailVC.swift
//  ListTodo
//
//  Created by Muhammad Moaz Khan on 16/03/2018.
//  Copyright © 2018 MK. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var detailTextView: UITextView!
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the detail text
        detailTextView.text = text
    }
}
