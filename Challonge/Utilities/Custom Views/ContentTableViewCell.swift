//
//  ContentTableViewCell.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    static var identifier = "ContentTableViewCell"
    
    func setContent(_ view: UIView) {
        contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        content = view
        setup()
    }
    
    private var content: UIView?
    
    private func setup() {
        guard let content = content else { return }
        contentView.addSubview(content)
        content.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
