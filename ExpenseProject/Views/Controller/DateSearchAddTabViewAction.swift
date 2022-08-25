//
//  Date&AddAction.swift
//  ExpenseProject
//
//  Created by Mahedee Zaman on 11/4/22.
//

import Foundation
import UIKit
import CoreData

extension ExpenseManager : ReloadTable {
    
    func callToReloadTable() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
        tableView.endUpdates()
    }
    
    @IBAction func pendingBarTapped(_ sender: UIButton) {
        pendingBar.isSelected = true
        paidBar.isSelected = false
        addButton.isEnabled = true
        addButton.isHidden = false
        ExpenseViewModel.fetchFromPending()
        updateTable()
    }
    
    @IBAction func paidBarTapped(_ sender: UIButton) {
        pendingBar.isSelected = false
        paidBar.isSelected = true
        addButton.isEnabled = false
        addButton.isHidden = true
        ExpenseViewModel.fetchFromPaid()
        updateTable()
    }
    
    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setMonth() {
        currentMonth = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        currentCompare = convertMonthToDouble()
        dateLabel.text = MonthNameFromID[currentMonth]
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let result = ExpenseData.fetchRequest() as NSFetchRequest<ExpenseData>
        let sortByRecurrent = NSSortDescriptor(key: CustomMessages.itemIcon, ascending: false)
        result.sortDescriptors = [sortByRecurrent]
        
        if let searchedText = searchedField.text, !searchedText.isEmpty {
            if pendingBar.isSelected == true {
                result.predicate = Predicates.predicateForSearchInPending(where: searchedText)
            } else {
                result.predicate = Predicates.predicateForSearchInPaid(where: searchedText)
            }
            
            do {
                dataItems = try dataContext?.fetch(result)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print(Errors.databaseFetchError)
            }
        } else {
            if pendingBar.isSelected == true {
                ExpenseViewModel.fetchFromPending()
                updateTable()
            } else {
                ExpenseViewModel.fetchFromPaid()
                updateTable()
            }
        }
        searchedField.text = CustomMessages.empty
        searchedField.placeholder = CustomMessages.searchPlaceHolder
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ClassNameConstants.expenseControllerName {
            let destination = segue.destination as! AddExpenseController
            destination.reloadDelegate = self
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: ClassNameConstants.expenseControllerName, sender: self)
    }
}
