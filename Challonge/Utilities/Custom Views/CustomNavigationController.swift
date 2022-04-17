//
//  CustomNavigationController.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import UIKit

class CustomNavigationController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
        setNavigationBarHidden(true, animated: false)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setNavigationBarHidden(true, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
