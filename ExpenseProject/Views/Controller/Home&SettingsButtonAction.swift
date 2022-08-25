//
//  HomeButtonAction.swift
//  ExpenseProject
//
//  Created by Mahedee Zaman on 11/4/22.
//

import Foundation
import UIKit

extension ExpenseManager {
    
    @IBAction func homeButtonTapped(_ sender: UIBarButtonItem) {
        pendingBar.isSelected = true
        paidBar.isSelected = false
        addButton.isEnabled = true
        addButton.isHidden = false
        ExpenseViewModel.fetchFromPending()
        updateTable()
     }
     
 
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: ClassNameConstants.settingsControllerName, sender: self)
    }
}
