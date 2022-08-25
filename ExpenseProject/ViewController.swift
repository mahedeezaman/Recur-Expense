//
//  ViewController.swift
//  ExpenseProject
//
//  Created by Mahedee Zaman on 11/4/22.
//

import UIKit

class ExpenseManager: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExpenseTableViewCell.nib(), forCellReuseIdentifier: ExpenseTableViewCell.nibName)
    }
}

