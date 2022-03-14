//
//  ProgrammaticView.swift
//  Challonge
//
//  Created by Антон Алексеев on 14.03.2022.
//

import UIKit
import SnapKit

class ProgrammaticView: UIView {
    convenience init(ownerController controller: UIViewController) {
        let superView: UIView = controller.view
        self.init(frame: superView.frame)
        self.controller = controller
        superView.addSubview(self)
        setup()
    }
    
    func setup() {
        snp.makeConstraints { maker in
            guard let _ = superview else { return }
            maker.edges.equalToSuperview()
        }
    }
    
    private weak var controller: UIViewController!
}
