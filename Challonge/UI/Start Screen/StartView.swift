//
//  TestView.swift
//  Challonge
//
//  Created by Антон Алексеев on 14.03.2022.
//

import UIKit

protocol StartViewDelegate {
    func createButtonDidPress()
}

class StartView: ProgrammaticView {
    // MARK: - Views
    private let container = UIView()
    
    private let loginTextField = CustomTextField(placeholder: "Логин")
    
    private let apiKeyTextField = CustomTextField(placeholder: "API Ключ")
    
    private let createButton = CustomButton(withTitle: "Создать турнир")
    
    // MARK: - Public
    override func setup() {
        super.setup()
        addSubviews()
        addConstraints()
        
        createButton.buttonDidPress = { [weak self] in
            self?.delegate?.createButtonDidPress()
        }
        
        loginTextField.text = "creagent"
        apiKeyTextField.text = "K73OxY8R5ty5mCtdrICvgYJSBtxIlzx8knxRuVIG"
    }
    
    var isCreateButtonActive = true {
        willSet {
            createButton.isUserInteractionEnabled = newValue
        }
    }
    
    var apiKey: String {
        apiKeyTextField.text ?? ""
    }
    
    var login: String {
        loginTextField.text ?? ""
    }
    
    var delegate: StartViewDelegate?
}

// MARK: - Setup
private extension StartView {
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
            maker.width.greaterThanOrEqualTo(300)
        }
    }
}
