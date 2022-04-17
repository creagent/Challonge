//
//  CustomStackView.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import UIKit

class CustomStackView: UIStackView {
    // MARK: - Init
    convenience init(vertical: Bool,
                     withSpacing spacing: CGFloat = 0.0,
                     distribution: UIStackView.Distribution = .fill,
                     alignment: UIStackView.Alignment = .fill) {
        self.init()
        axis =  vertical ? .vertical : .horizontal
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}
