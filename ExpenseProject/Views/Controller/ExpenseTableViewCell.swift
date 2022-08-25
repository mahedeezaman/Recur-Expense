//
//  ExpenseTableViewCell.swift
//  ExpenseProject
//
//  Created by Mahedee Zaman on 11/4/22.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var recurrenceIcon: UIImageView!
    @IBOutlet weak var expenseReason: UILabel!
    @IBOutlet weak var expenseAmount: UILabel!
    @IBOutlet weak var expenseCatagory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: ClassNameConstants.expenseCellNibName, bundle: nil)
    }
    
}
