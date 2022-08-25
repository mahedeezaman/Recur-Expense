//
//  ViewController.swift
//  ExpenseProject
//
//  Created by Mahedee Zaman on 11/4/22.
//

import UIKit

class ExpenseManager: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pendingBar: UIButton!
    @IBOutlet weak var paidBar: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchedField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMonth()
        pendingBar.isSelected = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExpenseTableViewCell.nib(), forCellReuseIdentifier: ClassNameConstants.expenseCellNibName)
            ExpenseViewModel.fetchFromPending()
    }
}

