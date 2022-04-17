//
//  RadioElementView.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import UIKit

class RadioElementView: UIView {
    convenience init(text: String, value: Any? = nil, isSelected: Bool = false) {
        self.init(frame: .zero)
        elementTextLabel.text = text
        self.value = value
        radioButton.isSelected = isSelected
        setup()
    }
    
    private let container = UIView()
    
    private let elementTextLabel = UILabel()
    
    let radioButton = RadioButton()
    
    private(set) var value: Any?
    
    var text: String {
        elementTextLabel.text ?? ""
    }
    
    @objc private func tap() {
        radioButton.sendActions(for: .touchUpInside)
    }
}

private extension RadioElementView {
    func setup() {
        setupContainer()
        setupRadioButton()
        setupElementTextLabel()
    }
    
    func setupContainer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
        container.addGestureRecognizer(tap)
        addSubview(container)
        container.snp.makeConstraints { maker in
            maker.top.leading.bottom.equalToSuperview()
        }
    }
    
    func setupRadioButton() {
        container.addSubview(radioButton)
        radioButton.snp.makeConstraints { maker in
            maker.top.leading.bottom.equalToSuperview()
            maker.width.height.equalTo(22.0)
        }
    }
    
    func setupElementTextLabel() {
        elementTextLabel.sizeToFit()
        container.addSubview(elementTextLabel)
        elementTextLabel.snp.makeConstraints { maker in
            maker.centerY.trailing.equalToSuperview()
            maker.leading.equalTo(radioButton.snp.trailing).offset(12)
            maker.trailing.equalToSuperview()
        }
    }
}
