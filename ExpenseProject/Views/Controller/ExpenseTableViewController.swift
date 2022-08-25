//
//  TableViewController.swift
//  ExpenseProject
//
//  Created by Mahedee Zaman on 11/4/22.
//

import Foundation
import UIKit

extension ExpenseManager : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassNameConstants.expenseCellNibName, for: indexPath) as! ExpenseTableViewCell
        cell.expenseReason.text = dataItems![indexPath.row].titleCost
        cell.expenseAmount.text = "\(dataItems![indexPath.row].amountCost)"
        cell.expenseCatagory.text = dataItems![indexPath.row].catagory
        cell.recurrenceIcon.image = dataItems![indexPath.row].itemIcon == true ? CustomMessages.recurrentIcon : CustomMessages.nonRecurrentIcon
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if pendingBar.isSelected == true {
            let alert = UIAlertController(title: CustomMessages.pay, message: "Are you sure to pay for this item?", preferredStyle: .alert)
            
            let confirmBtn = UIAlertAction(title: CustomMessages.confirm, style: .default) { (action) in
                dataItems![indexPath.row].isPaid = true
                do{
                    try dataContext?.save()
                }
                catch{
                    print(Errors.databaseSaveAfterDelete)
                }
                
                dataItems?.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
            
            let cancelBtn = UIAlertAction(title: CustomMessages.cancel, style: .destructive) { (action) in
                alert.dismiss(animated: true)
            }
            
            alert.addAction(cancelBtn)
            alert.addAction(confirmBtn)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if pendingBar.isSelected == true {
            let action = UIContextualAction(style: .destructive, title: CustomMessages.delete, handler: {(action, view, handler) in
                let remove = dataItems![indexPath.row]
                dataContext?.delete(remove)
                
                do{
                    try dataContext?.save()
                }
                catch{
                    print(Errors.databaseSaveAfterDelete)
                }
                
                dataItems?.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            })
            
            return UISwipeActionsConfiguration(actions: [action])
        }
        return UISwipeActionsConfiguration(actions: [])
    }
}
