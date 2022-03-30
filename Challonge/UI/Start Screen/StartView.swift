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
    private let container = UIView()
    
    private let loginTextField = CustomTextField(placeholder: "Логин")
    
    private let apiKeyTextField = CustomTextField(placeholder: "API Ключ")
    
    private let createButton = CustomButton(withTitle: "Создать турнир")
    
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
        }
    }
}


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

class CustomButton: UIButton {
    // MARK: - Lifecycle
    override var isUserInteractionEnabled: Bool {
        didSet {
            if !isUserInteractionEnabled && color != .clear {
                backgroundColor = color.withAlphaComponent(0.7)
            } else {
                backgroundColor = color
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = color
        }
    }
        
    // MARK: - Init
    convenience init(withTitle title: String, handler: (() -> Void)? = nil) {
        self.init(frame: CGRect())
        setTitle(title, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        setup()
    }
    
    // MARK: - Public properties
    var buttonDidPress: (() -> Void)?
    var color: UIColor { .systemOrange }
    var titleColor: UIColor { .black }
    
    static let height: CGFloat = 48.0
    
    // MARK: - Action
    @objc private func press(sender: UIButton) {
        buttonDidPress?()
    }
}

// MARK: - Private
extension CustomButton {
    private func setup() {
        snp.makeConstraints { maker in
            maker.height.equalTo(Self.height)
        }
        backgroundColor = color
        setTitleColor(titleColor, for: .normal)
        addTarget(self, action: #selector(press(sender:)), for: .touchUpInside)
    }
}
