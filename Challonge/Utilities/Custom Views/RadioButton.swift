//
//  RadioButton.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import UIKit

class RadioButton: UIButton {
    convenience init(isSelected: Bool = false) {
        self.init()
        self.isSelected = isSelected
        setup()
    }
    
    override var isSelected: Bool {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        let image: UIImage = isSelected ? UIImage(named: "radioSelected")! : UIImage(named: "radioUnselected")!
        setImage(image, for: .normal)
    }
}
