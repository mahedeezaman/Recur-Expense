//
//  TabViewTapped.swift
//  ExpenseProject
//
//  Created by Mahedee Zaman on 11/4/22.
//

import Foundation
import UIKit
import CoreData

class ExpenseViewModel {
    
    static func fetchFromPrevMonth(){
        do {
            let result = ExpenseData.fetchRequest() as NSFetchRequest<ExpenseData>
            result.predicate = Predicates.predicateForRecurrentAdd
            
            dataItems = try dataContext?.fetch(result)
            
            if let items = dataItems {
                for item in items {
                    item.recurrent = false
                    
                    let newExpense = ExpenseData(context: dataContext ?? (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
                    newExpense.isPaid = false
                    newExpense.recurrent = true
                    newExpense.titleCost = item.titleCost
                    newExpense.descriptionCost = item.descriptionCost
                    newExpense.catagory = item.catagory
                    newExpense.amountCost = item.amountCost
                    newExpense.monthId = convertMonthToDouble()
                    newExpense.itemIcon = true
                    
                    dataItems?.append(newExpense)
                }
                do{
                    try dataContext?.save()
                }
                catch{
                    print(Errors.databaseSaveAfterAdd)
                }
                
            } else {
                print(Errors.databaseFetchError)
            }
            
        } catch {
            print(Errors.databaseFetchError)
        }
    }
    
    static func fetchFromPending(){
        fetchFromPrevMonth()
        do {
            let result = ExpenseData.fetchRequest() as NSFetchRequest<ExpenseData>
            let sortByRecurrent = NSSortDescriptor(key: "itemIcon", ascending: false)
            result.sortDescriptors = [sortByRecurrent]
            result.predicate = Predicates.predicateForPending
            
            dataItems = try dataContext?.fetch(result)
            
        } catch {
            print(Errors.databaseFetchError)
        }
    }
    
    static func fetchFromPaid(){
        do {
            let result = ExpenseData.fetchRequest() as NSFetchRequest<ExpenseData>
            let sortByRecurrent = NSSortDescriptor(key: "itemIcon", ascending: false)
            result.sortDescriptors = [sortByRecurrent]
            result.predicate = Predicates.predicateForPaid
            
            dataItems = try dataContext?.fetch(result)
            
        } catch {
            print(Errors.databaseFetchError)
        }
    }
}
