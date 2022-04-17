//
//  DateFormFieldView.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import UIKit

class DateFormFieldView: FormFieldView {
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()
    
    convenience init(title: String? = nil, initialDate: Date) {
        self.init(title: title, placeholder: "")
        textfield.text = initialDate.dateString
        textfield.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done))
        toolbar.setItems([doneButton], animated: true)
        textfield.inputAccessoryView = toolbar
    }
    
    @objc func done() {
        endEditing(true)
    }
    
    @objc func dateChanged() {
        textfield.text = datePicker.date.dateString
    }
}
