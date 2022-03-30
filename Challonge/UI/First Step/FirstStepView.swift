//
//  FirstStepView.swift
//  Challonge
//
//  Created by Антон Алексеев on 22.03.2022.
//

import UIKit

protocol FirstStepViewDelegate {
    func closeButtonDidPress()
}

class FirstStepView: ProgrammaticView {
    private let container = UIView()
    
    private var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Закрыть", for: .normal)
        return button
    }()
    
    override func setup() {
        super.setup()
        addSubviews()
        addConstraints()
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    var delegate: FirstStepViewDelegate?
}

private extension FirstStepView {
    func addSubviews() {
        addSubview(closeButton)
    }
    
    func addConstraints() {
        closeButton.snp.makeConstraints { maker in
            maker.top.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    @objc func close() {
        delegate?.closeButtonDidPress()
    }
}
