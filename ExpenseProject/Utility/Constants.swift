//
//  Constants.swift
//  ExpenseProject
//
//  Created by Mahedee Zaman on 12/4/22.
//

import Foundation
import UIKit
import CoreData

struct ClassNameConstants {
    static let expenseCellNibName = "ExpenseTableViewCell"
    static let expenseControllerName = "AddExpenseController"
    static let settingsControllerName = "SettingsViewController"
}

struct CustomMessages {
    static let confirm = "Confirm"
    static let cancel = "Cancel"
    static let pay = "Pay?"
    static let delete = "Delete"
    static let empty = ""
    static let searchPlaceHolder = "Search by Title / Description"
    static let nonRecurrentIcon = UIImage(systemName: "circle.slash")
    static let recurrentIcon = UIImage(systemName: "circle.dashed.inset.filled")
    static let itemIcon = "itemIcon"
}

struct Errors {
    static let databaseFetchError = "Couldnt fetch from database"
    static let databaseSaveAfterDelete = "Couldn't save after Deleting"
    static let databaseSaveAfterPay = "Couldn't save after Paying"
    static let databaseSaveAfterAdd = "Couldn't save after Adding"
}

struct Predicates {
    
    static let predicateForRecurrentAdd = NSPredicate(format: "monthId == %@ && recurrent != %@", "\(convertToPrevMonth())", "false")
    
    static let predicateForPending = NSPredicate(format: "monthId == %@ && isPaid == %@", "\(currentCompare)", "false")
    
    static let predicateForPaid = NSPredicate(format: "monthId == %@ && isPaid != %@", "\(currentCompare)", "false")
    
    static func predicateForSearchInPending(where searchedText : String) -> NSPredicate{
        return NSPredicate(format: "monthId == %@ && isPaid == %@ && (titleCost contains %@ || descriptionCost contains %@)", "\(currentCompare)", "false", "\(searchedText)", "\(searchedText)")
    }
    
    static func predicateForSearchInPaid(where searchedText : String) -> NSPredicate{
        return NSPredicate(format: "monthId == %@ && isPaid != %@ && (titleCost contains %@ || descriptionCost contains %@)", "\(currentCompare)", "false", "\(searchedText)", "\(searchedText)")
    }
}

var dataItems : [ExpenseData]?
var dataContext : NSManagedObjectContext? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
var currentMonth : Int = 0
var currentYear : Int = 0
var currentCompare : Double = 0.0
let datePicker = UIDatePicker()
let formatter = DateFormatter()

var MonthNameFromID = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
]

func convertMonthToDouble(year : Int = currentYear, month : Int = currentMonth) -> Double {
    let temp = Double(year) + Double(month)/12.0
    return Double(round(100 * temp) / 100)
}

func convertToPrevMonth()->Double {
    let temp = Double(currentYear) + Double(currentMonth - 1)/12.0
    return Double(round(100*temp) / 100)
}
