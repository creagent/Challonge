//
//  TestView.swift
//  Challonge
//
//  Created by Антон Алексеев on 14.03.2022.
//

import UIKit

class TestView: ProgrammaticView {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override func setup() {
        super.setup()
        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }
}
