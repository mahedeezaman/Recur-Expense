//
//  SettingsViewController.swift
//  ExpenseProject
//
//  Created by Mahedee Zaman on 12/4/22.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("in deinit of \(#file)")
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
