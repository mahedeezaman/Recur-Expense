//
//  AddExpenseController.swift
//  ExpenseProject
//
//  Created by Mahedee Zaman on 11/4/22.
//

import UIKit

class AddExpenseController: UIViewController {

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var catagoryLabel: UITextField!
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var recurrentSwitch: UISwitch!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var reloadDelegate : ReloadTable?
    
    deinit {
        print("in deinit of \(#file)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        doneButton.isEnabled = false
        recurrentSwitch.isOn = false
        
        setupDatePicker()
        
        [titleLabel, descriptionLabel, catagoryLabel, amountLabel, dateLabel].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }

    func setupDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnPressed))
        toolbar.setItems([doneBtn], animated: true)
        
        dateLabel.inputAccessoryView = toolbar
        dateLabel.inputView = datePicker
        dateLabel.text = formatter.string(from: datePicker.date)
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        let title = titleLabel.text
        let description = descriptionLabel.text
        let catagory = catagoryLabel.text
        let amount = Int64(amountLabel.text ?? "0") ?? 0
        let month = Calendar.current.component(.month, from: datePicker.date)
        let year = Calendar.current.component(.year, from: datePicker.date)
        let recurrent = Bool(recurrentSwitch.isOn)
        
        let newExpense = ExpenseData(context: dataContext ?? (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        
        newExpense.isPaid = false
        newExpense.recurrent = recurrent
        newExpense.titleCost = title
        newExpense.descriptionCost = description
        newExpense.catagory = catagory
        newExpense.amountCost = amount
        newExpense.monthId = convertMonthToDouble(year: year, month: month)
        newExpense.itemIcon = recurrent == true ? true : false
        
        do{
            try dataContext?.save()
        }
        catch{
            print(Errors.databaseSaveAfterAdd)
        }
        
        dataItems?.insert(newExpense, at: 0)
        reloadDelegate?.callToReloadTable()
        dismiss(animated: true)
     }

}


// MARK :- Closure
extension AddExpenseController {
    
    @objc func doneBtnPressed(){
        dateLabel.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        
        guard
            let title = titleLabel.text, !title.isEmpty,
            let description = descriptionLabel.text, !description.isEmpty,
            let catagory = catagoryLabel.text, !catagory.isEmpty,
            let amount = amountLabel.text, !amount.isEmpty
        else {
            self.doneButton.isEnabled = false
              return
        
        }
        doneButton.isEnabled = true
    }
}
