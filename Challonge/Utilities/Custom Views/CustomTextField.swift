//
//  CustomTextField.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import UIKit

class CustomTextField: UITextField {
    // MARK: - Public
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: 16)
        textAlignment = .left
        self.placeholder = placeholder
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        clearButtonMode = .whileEditing
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: verticalInset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: verticalInset)
    }
    
    // MARK: - Private
    private let horizontalInset: CGFloat = 16
    
    private let verticalInset: CGFloat = 16
}
