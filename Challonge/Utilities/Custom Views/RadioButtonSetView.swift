//
//  RadioButtonSetView.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import UIKit

private extension RadioButtonSetView {
    struct Appearance {
        static let spacing: CGFloat = 16.0
        
        static let topOffset: CGFloat = 12.0
        
        static let errorContainerTopOffset: CGFloat = 8.0
        static let errorContainerHeight: CGFloat = 18.0
    }
}

class RadioButtonSetView: UIView {
    // MARK: - Views
    private let titleLabel = UILabel()
    
    private let stackView = CustomStackView(vertical: true, withSpacing: Appearance.spacing)
    
    // MARK: - Public
    convenience init(title: String, elements: [RadioElementView]) {
        self.init(frame: .zero)
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 0
        self.elements = elements
        for i in 0..<elements.count {
            let button = elements[i].radioButton
            button.addTarget(self, action: #selector(setSelected(sender:)), for: .touchUpInside)
            if button.isSelected {
                selectedIndex = i
            }
        }
        addSubviews()
        layoutConstraints()
    }
    
    private(set) var selectedIndex: Int?
    
    var selectedValue: Any? {
        elements[selectedIndex ?? 0].value
    }
    
    // MARK: - Private
    private var elements: [RadioElementView] = []
}

// MARK: - Setup
private extension RadioButtonSetView {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(stackView)
        elements.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func layoutConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(Appearance.topOffset)
            maker.width.equalTo(300)
            maker.centerX.equalToSuperview()
        }
        stackView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.width.equalTo(300)
            maker.bottom.equalToSuperview().inset(Appearance.topOffset)
            maker.top.equalTo(titleLabel.snp.bottom).offset(Appearance.topOffset)
        }
    }
    
    // MARK: - Actions
    @objc func setSelected(sender: RadioButton) {
        sender.isSelected = true
        for i in 0..<elements.count {
            let button = elements[i].radioButton
            if button != sender {
                button.isSelected = false
            } else {
                selectedIndex = i
            }
        }
    }
}
