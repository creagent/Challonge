//
//  FirstStepView.swift
//  Challonge
//
//  Created by Антон Алексеев on 22.03.2022.
//

import UIKit

protocol FirstStepViewDelegate {
    func closeButtonDidPress()
    func nextButtonDidPress()
    var navigationBarItem: UINavigationItem? { get }
}

class FirstStepView: ProgrammaticView {
    private let container = UIView()
    
    private var nextButton = CustomButton(withTitle: "Далее")
    
    override func setup() {
        super.setup()
        addSubviews()
        addConstraints()
        
        nextButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
    }
    
    var delegate: FirstStepViewDelegate? {
        didSet {
            delegate?.navigationBarItem?.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(close))
        }
    }
}

private extension FirstStepView {
    func addSubviews() {
        addSubview(nextButton)
    }
    
    func addConstraints() {
        nextButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            maker.width.greaterThanOrEqualTo(300)
        }
    }
    
    @objc func close() {
        delegate?.closeButtonDidPress()
    }
    
    @objc func nextStep() {
        delegate?.nextButtonDidPress()
    }
}
