//
//  FirstStepView.swift
//  Challonge
//
//  Created by Антон Алексеев on 22.03.2022.
//

import UIKit

class FirstStepView: ProgrammaticView {
    private let container = UIView()
    
    private let loginTextField = CustomTextField(placeholder: "Логин")
    
    private let apiKeyTextField = CustomTextField(placeholder: "API Ключ")
    
    private let createButton = CustomButton(withTitle: "Создать турнир")
    
    override func setup() {
        super.setup()
        addSubviews()
        addConstraints()
    }
}

private extension FirstStepView {
    func addSubviews() {
        addSubview(container)
        container.addSubview(loginTextField)
        container.addSubview(apiKeyTextField)
        container.addSubview(createButton)
    }
    
    func addConstraints() {
        container.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.leading.trailing.equalToSuperview().inset(40)
        }
        
        loginTextField.snp.makeConstraints { maker in
            maker.top.leading.trailing.equalToSuperview()
        }
        
        apiKeyTextField.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(loginTextField.snp.bottom).offset(16)
        }
        
        createButton.snp.makeConstraints { maker in
            maker.centerX.bottom.equalToSuperview()
            maker.top.equalTo(apiKeyTextField.snp.bottom).offset(32)
        }
    }
}
