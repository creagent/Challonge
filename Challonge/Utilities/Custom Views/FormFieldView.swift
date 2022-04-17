//
//  FormFieldView.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import UIKit

class FormFieldView: UIView {
    private let titleStackView = CustomStackView(vertical: true)
    private let titleLabel = UILabel()
    
    private(set) var textfield = CustomTextField(placeholder: "")
    
    convenience init(title: String? = nil, placeholder: String) {
        self.init(frame: .zero)
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.isHidden = title == nil
        textfield = CustomTextField(placeholder: placeholder)
        setup()
    }
    
    var text: String {
        textfield.text ?? ""
    }
    
    private func setup() {
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(16)
            maker.width.equalTo(300)
        }
        
        addSubview(textfield)
        textfield.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(titleStackView.snp.bottom).offset(16)
            maker.bottom.equalToSuperview().inset(16)
            maker.width.equalTo(300)
        }
    }
}
