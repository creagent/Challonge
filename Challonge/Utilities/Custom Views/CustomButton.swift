//
//  CustomButton.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import UIKit

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
